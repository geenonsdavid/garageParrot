import 'package:flutter/material.dart';
import 'package:garage_parrot/services/api_service.dart';
import 'package:garage_parrot/components/customfield.dart';
import 'package:garage_parrot/src/utils/dialog_helpers.dart';
import 'package:garage_parrot/components/list_workers.dart';
import 'package:garage_parrot/models/user.dart';
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

  // Liste des labels et des textes d'indice pour les champs du formulaire
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

  // Liste des focus nodes pour gérer la navigation entre les champs
  late final _focusNodes = List.generate(_fields.length, (index) => FocusNode());

  // Liste des contrôleurs pour récupérer les valeurs des champs du formulaire
  late final _controllers = List.generate(_fields.length, (index) => TextEditingController());

  // Créer une instance d'ApiService pour les appels API
  final ApiService apiservice = ApiService();

  // Créer une instance de Validator pour la validation des champs
  final Validator validator = Validator();

  // Fonction pour effacer les champs du formulaire
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
    // Vérifier la robustesse du mot de passe
    double strength = estimatePasswordStrength(value);
    if (strength < 0.8) {
      return "Mot de passe trop faible";
    }

    // Vérifier si les mots de passe correspondent
    if (index == 5 && value != _controllers[4].text) {
      return "Les mots de passe ne correspondent pas";
    }
    return null;
  }

  // Récupérer les travailleurs via l'API
  Future<void> getworkers() async {
    await apiservice.getUsers();
  }

  // Construire un champ personnalisé
  Widget _buildCustomField(int index, String label, String hintText) {
    return Column(
      children: [
        CustomField(
            obscureText: index == 4 || index == 5,
            controller: _controllers[index],
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

  // Construire l'interface du formulaire
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
            ..._buildCustomFields(), // Champs personnalisés
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildSubmitButton("Liste des employés", _viewList), // Bouton pour afficher la liste des employés
                _buildSubmitButton("Ajouter un employé", _onSubmit), // Bouton pour ajouter un employé
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Construire un bouton de soumission
  Widget _buildSubmitButton(String label, VoidCallback onSubmit) => ElevatedButton.icon(
        icon: const Icon(Icons.task_alt),
        onPressed: onSubmit,
        label: Text(label),
      );

  // Valider et soumettre le formulaire
  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      // Vérifier si l'email existe déjà
      final email = _controllers[2].text.trim();
      bool emailExists = await checkIfEmailExists(email);
      if (emailExists) {
        if (mounted) showErrorDialog(context, "L'email existe déjà !");
      } else {
        User newUser = User(
          id: "",
          name: _controllers[0].text.trim(),
          lastname: _controllers[1].text.trim(),
          email: _controllers[2].text.trim(),
          phone: _controllers[3].text.trim(),
          userpassword: _controllers[4].text.trim(),
        );
        try {
          bool success = await apiservice.insertUser(newUser);
          if (success) {
            if (mounted) showSuccessDialog(context, "Employé créé avec succès");
            _clearForm();
          } else {
            if (mounted) showErrorDialog(context, "Erreur lors de la création de l'employé");
          }
        } catch (e) {
          if (mounted) showErrorDialog(context, "Une erreur est survenue : $e");
        }
      }
    }
  }

  // Ouvrir la vue de la liste des employés
  void _viewList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListUsers()),
    );
  }

  // Construire les champs personnalisés
  List<Widget> _buildCustomFields() => List.generate(
        _fields.length,
        (index) => _buildCustomField(
          index,
          _fields[index]["label"]!,
          _fields[index]["hintText"]!,
        ),
      );

  // Vérifier si l'email existe déjà
  Future<bool> checkIfEmailExists(String email) async {
    try {
      List<User> workers = await apiservice.getUsers();

      for (var worker in workers) {
        if (worker.email == email) {
          return true;
        }
      }
      return false;
    } catch (e) {
      debugPrint('Erreur de vérification de l\'email: $e');
      return false;
    }
  }
}
