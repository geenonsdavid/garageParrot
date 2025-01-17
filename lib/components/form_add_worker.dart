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
  //final _lastnameFocusNode = FocusNode();
  //final _nameFocusNode = FocusNode();
  //final _emailFocusNode = FocusNode();
  //final _phoneFocusNode = FocusNode();
  //final _messageFocusNode = FocusNode();
  final _focusNodes = List.generate(5, (index) => FocusNode());
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  

  Future<void> insertrecord() async {
    if (_nameController.text.isEmpty ||
        _lastnameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      if (mounted) {
        showErrorDialog(context, "Veuillez remplir tous les champs");
      }
      return;
    }

    try {
      String uri = "http://192.168.1.69/garageparrot_api/insert_record.php";

      var res = await http.post(Uri.parse(uri), body: {
        "name": _nameController.text,
        "lastname": _lastnameController.text,
        "email": _emailController.text,
        "phone": _phoneController.text
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
      if(mounted){
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
              controller: _nameController,
              context: context,
              customLabel: "nom",
              customHintText: "Veuillez le nom de l'employé",
              customFocus: _focusNodes[0],
              customRequestFocus: _focusNodes[1],
            ),
            const SizedBox(height: 10),
            CustomField(
              controller: _lastnameController,
              context: context,
              customLabel: "Prénom",
              customHintText: "Veuillez entrer votre prénom",
              customFocus: _focusNodes[1],
              customRequestFocus: _focusNodes[2],
            ),
            const SizedBox(height: 10),
            CustomField(
              controller: _emailController,
              context: context,
              customLabel: "Email",
              customHintText: "Veuillez entrer son email",
              customFocus: _focusNodes[2],
              customRequestFocus: _focusNodes[3],
            ),
            const SizedBox(height: 10),
            CustomField(
              controller: _phoneController,
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
