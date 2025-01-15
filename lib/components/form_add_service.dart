import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_parrot/components/customfield.dart';
import 'package:garage_parrot/themes/colors.dart';

class FormAddService extends StatefulWidget {
  const FormAddService({super.key});

  @override
  State<FormAddService> createState() => _FormAddServiceState();
}

class _FormAddServiceState extends State<FormAddService> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _serviceFocus = FocusNode();
  final _discribeFocus = FocusNode();
  final _buttonFocus = FocusNode();
  final _titleController = TextEditingController();
  final _discribeController = TextEditingController();

  // list des maps
  final List<Map<String, String>> _formDataList = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: secondary),
            borderRadius: BorderRadius.circular(8)),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: IconButton(
                  onPressed: () {
                    debugPrint("vous voulez ajoutez une photo");
                  },
                  icon: const Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 80,
                    color: secondary,
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
                  context: context,
                  customLabel: "Titre du service",
                  customHintText: "Choisir le titre",
                  customFocus: _serviceFocus,
                  customRequestFocus: _discribeFocus,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CustomField(
                  controller: _discribeController,
                  context: context,
                  customLabel: "Description",
                  customHintText: "décrire le service",
                  customFocus: _discribeFocus,
                  customRequestFocus: _buttonFocus,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton.icon(
                    focusNode: _buttonFocus,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Si le formulaire est valide, soumettre les données
                        _addFormDataToList();
                        // Effacer le formulaire
                        _clearFormField();
                      }
                    },
                    icon: SvgPicture.asset(
                      "./assets/icons/circle-plus-solid.svg",
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        secondary,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: const Text("Ajoutez")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Ajouter les données saisies à la liste
  void _addFormDataToList() {
    final Map<String, String> formData = {
      'title': _titleController.text,
      'description': _discribeController.text,
    };
    setState(() {
      _formDataList.add(formData);
      debugPrint("Liste des données: $_formDataList");
    });
  }

  // efface les champs de saisie

  _clearFormField() {
    setState(() {
      _titleController.clear();
      _discribeController.clear();
    });
  }
}
