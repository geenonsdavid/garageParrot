import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:garage_parrot/components/customfield.dart';
import 'package:garage_parrot/themes/colors.dart';
import 'package:http/http.dart' as http;
import 'package:garage_parrot/components/dialog_helpers.dart';

class FormAddWorker extends StatefulWidget {
  const FormAddWorker({super.key});

  @override
  State<FormAddWorker> createState() => _FormAddWorkerState();
}

class _FormAddWorkerState extends State<FormAddWorker> {
  final _formKey = GlobalKey<FormState>();
  
  final List<Map<String, String>> _fields = [
    {"label": "Nom", "hintText": "Veuillez entrer le nom de l'employé"},
    {"label": "Prénom", "hintText": "Veuillez entrer le prénom de l'employé"},
    {"label": "Email", "hintText": "Veuillez entrer son email"},
    {"label": "Téléphone", "hintText": "Veuillez entrer son numéro de téléphone"},
  ];
  
  final _focusNodes = List.generate(5, (index) => FocusNode());
  late final _controllers = List.generate(_fields.length, (index) => TextEditingController());

  Future<void> insertrecord() async {
    if (_controllers.any((controller) => controller.text.isEmpty)) {
      if (mounted) {
        showErrorDialog(context, "Veuillez remplir tous les champs");
      }
      return;
    }

    try {
      String uri = "http://192.168.1.69/garageparrot_api/insert_record.php";

      var res = await http.post(Uri.parse(uri), body: {
        "name": _controllers[0].text,
        "lastname": _controllers[1].text,
        "email": _controllers[2].text,
        "phone": _controllers[3].text,
      });
      if (res.statusCode != 200) {
        if (mounted) {
          showErrorDialog(context, "Erreur lors de la connexion au serveur");
        }
        return;
      }

      var response = jsonDecode(res.body);
      if (mounted) {
        if (response["success"] == "true") {
          showSuccessDialog(context, "Employé créé avec succès");
        } else {
          showErrorDialog(context, "Erreur lors de la création de l'employé");
        }
      }
    } catch (e) {
      if (mounted) {
        showErrorDialog(context, "erreur de requête: $e");
      }
    }
  }

Widget _buildCustomField(int index, String label, String hintText) {
    return Column(
      children: [
        CustomField(
          controller: _controllers[index],
          context: context,
          customLabel: label,
          customHintText: hintText,
          customFocus: _focusNodes[index],
          customRequestFocus: index < _focusNodes.length - 1 ? _focusNodes[index + 1] : FocusNode(),
        ),
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
            for (int i = 0; i < _fields.length; i++)
              _buildCustomField(i, _fields[i]["label"]!, _fields[i]["hintText"]!),
            // Add TextFormFields and ElevatedButton here.
            //_buildCustomField(0, "Nom", "Veuillez entrer le nom de l'employé"),
            //_buildCustomField(1, "Prénom", "Veuillez entrer le prénom de l'employé"),
            //_buildCustomField(2, "Email", "Veuillez entrer son email"),
            //_buildCustomField(3, "Téléphone", "Veuillez son numéro de téléphone"),
            ElevatedButton.icon(
              icon: const Icon(Icons.task_alt),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  insertrecord();
                }
              },
              label: const Text("Envoyez"),
            ),
          ],
        ),
      ),
    );
  }
}
