import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_parrot/models/service_auto.dart';
import 'package:garage_parrot/services/api_service.dart';
import 'package:garage_parrot/src/utils/dialog_helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:garage_parrot/components/customfield.dart';
import 'package:garage_parrot/themes/colors.dart';
import 'dart:typed_data'; // Pour stocker les fichiers en mémoire

class FormAddService extends StatefulWidget {
  const FormAddService({super.key});

  @override
  State<FormAddService> createState() => _FormAddServiceState();
}

class _FormAddServiceState extends State<FormAddService> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _serviceFocus = FocusNode();
  final _describeFocus = FocusNode();
  final _buttonFocus = FocusNode();
  final _titleController = TextEditingController();
  final _describeController = TextEditingController();
  
  Uint8List? _imageBytes; // Image en mémoire (pour le web)
  bool _isLoading = false; // Ajout de l'état de chargement

  final ApiService apiservice = ApiService(); // Instance du service API

  @override
  void dispose() {
    _serviceFocus.dispose();
    _describeFocus.dispose();
    _buttonFocus.dispose();
    _titleController.dispose();
    _describeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final Uint8List imageData = await image.readAsBytes(); // Lire en mémoire
      setState(() {
        _imageBytes = imageData;
      });
    }
  }

  Future<void> _addFormDataToList() async {
    if (!_formKey.currentState!.validate()) return;

    if (_imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text("Veuillez sélectionner une image.")),
);

      return;
    }

    setState(() => _isLoading = true);

    final ServiceAuto newService = ServiceAuto(
      title: _titleController.text,
      description: _describeController.text,
      photo: _imageBytes!,
    );

    try {
      bool success = await apiservice.insertService(newService);

      if (success) {
        if (mounted) {
          showSuccessDialog(context, "Service créé avec succès");
          _clearFormField();
        }
      } else {
        if (mounted) showErrorDialog(context, "Erreur lors de la création du service");
      }
    } catch (e) {
      if (mounted) showErrorDialog(context, "Une erreur est survenue : $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _clearFormField() {
    _titleController.clear();
    _describeController.clear();
    setState(() {
      _imageBytes = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: secondary),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _imageBytes == null
                    ? const SizedBox(
                        height: 80,
                        width: 80,
                        child: Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 80,
                          color: secondary,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          _imageBytes!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              Text(
                'Ajouter une photo',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CustomField(
                  controller: _titleController,
                  customLabel: "Titre du service",
                  customHintText: "Choisir le titre",
                  customFocus: _serviceFocus,
                  customRequestFocus: _describeFocus,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un titre';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CustomField(
                  controller: _describeController,
                  customLabel: "Description",
                  customHintText: "Décrire le service",
                  customFocus: _describeFocus,
                  customRequestFocus: _buttonFocus,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une description';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton.icon(
                  focusNode: _buttonFocus,
                  onPressed: _isLoading ? null : _addFormDataToList,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : SvgPicture.asset(
                          "assets/icons/circle-plus-solid.svg",
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                            secondary,
                            BlendMode.srcIn,
                          ),
                        ),
                  label: Text(_isLoading ? "Ajout..." : "Ajoutez"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
