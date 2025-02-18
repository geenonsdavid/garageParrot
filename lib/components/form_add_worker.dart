import 'package:flutter/material.dart';
import 'package:garage_parrot/components/api_service.dart';
import 'package:garage_parrot/components/customfield.dart';
import 'package:garage_parrot/src/utils/dialog_helpers.dart';
import 'package:garage_parrot/components/list_workers.dart';
import 'package:garage_parrot/components/worker.dart';
import 'package:garage_parrot/themes/colors.dart';
import 'package:garage_parrot/src/utils/validator.dart';
import 'package:password_strength/password_strength.dart';

class FormAddWorker extends StatefulWidget {
  const FormAddWorker({super.key});

  @override
  State<FormAddWorker> createState() => _FormAddWorkerState();
}

class _FormAddWorkerState extends State<FormAddWorker> {
  final _formKey = GlobalKey<FormState>();

  // list label et hintText
  final List<Map<String, String>> _fields = [
    {
      "label": "Nom",
      "hintText": "Veuillez entrer le nom de l'employé",
    },
    {
      "label": "Prénom",
      "hintText": "Veuillez entrer le prénom de l'employé",
    },
    {
      "label": "Email",
      "hintText": "Veuillez entrer son email",
    },
    {
      "label": "Téléphone",
      "hintText": "Veuillez entrer son numéro de téléphone",
    },
    {
      "label": "Mot de passe",
      "hintText": "Veuillez entrer son mot de passe",
    },
    {
      "label": "Confirmer le mot de passe",
      "hintText": "Veuillez confirmer son mot de passe",
    },
  ];

  // list of focus nodes
  late final _focusNodes =
      List.generate(_fields.length, (index) => FocusNode());

  // list of controllers
  late final _controllers =
      List.generate(_fields.length, (index) => TextEditingController());

  // créer instance ApiService
  final ApiService apiservice = ApiService();

  // crér instance Validator
  final Validator validator = Validator();

  void _clearForm() {
    for (var controller in _controllers) {
      controller.clear();
    }
  }

  // Validation des mots de passe
  String? _passwordValidator(int index, String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Veuillez remplir ce champ";
    }
    // verify strong password
    double strength = estimatePasswordStrength(value);
    if (strength < 0.8) {
      return "Mot de passe trop faible";
    }

    //if (index == 4 && value.length < 6) {
    //  return "Le mot de passe doit contenir au moins 6 caractères";
    //}
    if (index == 5 && value != _controllers[4].text) {
      return "Les mots de passe ne correspondent pas";
    }
    return null;
  }

  Future<void> getworkers() async {
    await apiservice.getWorkers();
  }

  // build custom field
  // index: index of the field
  // label: label of the field
  // hintText: hint text of the field
  // return: custom field widget
  Widget _buildCustomField(int index, String label, String hintText) {
    return Column(
      children: [
        CustomField(
            obscureText: index == 4 || index == 5,
            controller: _controllers[index],
            //context: context,
            customLabel: label,
            customHintText: hintText,
            customFocus: _focusNodes[index],
            customRequestFocus: index < _focusNodes.length - 1
                ? _focusNodes[index + 1]
                : FocusNode(),
            validator: (value) {
              if (index == 2) return validator.verifyEmail(value);
              if (index == 3) return validator.verifyPhoneNumber(value);
              if (index == 4 || index == 5) {
                return _passwordValidator(index, value);
              }
              return null;
            }),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(
            color: secondary,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            ..._buildCustomFields(), // custom fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildSubmitButton(
                    "Liste des employés", _viewList), // submit button,
                _buildSubmitButton(
                    "Ajouter un employé", _onSubmit) // submit button
                ,
              ],
            ),
          ],
        ),
      ),
    );
  }

  // build submit button
  // label: label of the button
  // onSubmit: function to call when the button is pressed
  // return: submit button widget
  Widget _buildSubmitButton(label, onSubmit) => ElevatedButton.icon(
        icon: const Icon(Icons.task_alt),
        onPressed: onSubmit,
        label: Text(label),
      );

  // on submit
  // validate the form
  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      // Vérifier si l'email existe déjà
      final email = _controllers[2].text.trim();
      bool emailExists = await checkIfEmailExists(email);
      if (emailExists) {
        if (mounted) showErrorDialog(context,"L'email existe déjà !");
      } else {
        Worker newWorker = Worker(
          id: "",
          name: _controllers[0].text.trim(),
          lastname: _controllers[1].text.trim(),
          email: _controllers[2].text.trim(),
          phone: _controllers[3].text.trim(),
          userpassword: _controllers[4].text.trim(),
        );
        try {
          bool success = await apiservice.insertWorker(newWorker);
          if (success) {
            if (mounted) showSuccessDialog(context, "Employé créé avec succès");
            _clearForm();
          } else {
            if (mounted) showErrorDialog(context,"Erreur lors de la création de l'employé");
          }
        } catch (e) {
          if (mounted) (context,"Une erreur est survenue : $e");
        }
      }
    }
  }

  // view list
  void _viewList() {
    // open view listWorkers
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListWorkers()),
    );
  }

  // build custom fields
  _buildCustomFields() => List.generate(
        _fields.length,
        (index) => _buildCustomField(
          index,
          _fields[index]["label"]!,
          _fields[index]["hintText"]!,
        ),
      );

  Future<bool> checkIfEmailExists(String email) async {
    try {
      // Récupère tous les travailleurs en appelant la méthode qui retourne la liste
      List<Worker> workers = await apiservice.getWorkers();

      if (workers.isNotEmpty) {
        // Parcours de la liste des travailleurs pour vérifier si l'email existe
        for (var worker in workers) {
          if (worker.email == email) {
            return true; // Si l'email est trouvé, il existe déjà
          }
        }
      }
      return false; // Si l'email n'a pas été trouvé
    } catch (e) {
      debugPrint('Erreur de vérification de l\'email: $e');
      return false; // En cas d'erreur, on considère que l'email n'existe pas
    }
  }
}
