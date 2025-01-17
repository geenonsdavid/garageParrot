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
  final _focusNodes = List.generate(5, (index) => FocusNode());
  final _controllers = List.generate(4, (index) => TextEditingController());

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
            // Add TextFormFields and ElevatedButton here.
            CustomField(
              controller: _controllers[0],
              context: context,
              customLabel: "nom",
              customHintText: "Veuillez le nom de l'employé",
              customFocus: _focusNodes[0],
              customRequestFocus: _focusNodes[1],
            ),
            const SizedBox(height: 10),
            CustomField(
              controller: _controllers[1],
              context: context,
              customLabel: "Prénom",
              customHintText: "Veuillez entrer votre prénom",
              customFocus: _focusNodes[1],
              customRequestFocus: _focusNodes[2],
            ),
            const SizedBox(height: 10),
            CustomField(
              controller: _controllers[2],
              context: context,
              customLabel: "Email",
              customHintText: "Veuillez entrer son email",
              customFocus: _focusNodes[2],
              customRequestFocus: _focusNodes[3],
            ),
            const SizedBox(height: 10),
            CustomField(
              controller: _controllers[3],
              context: context,
              customLabel: "Téléphone",
              customHintText: "Veuillez entrer votre téléphone",
              customFocus: _focusNodes[3],
              customRequestFocus: _focusNodes[4],
            ),
            const SizedBox(height: 10),

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
