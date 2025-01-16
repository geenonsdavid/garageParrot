import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garage_parrot/components/customfield.dart';
import 'package:garage_parrot/themes/colors.dart';
import 'package:http/http.dart' as http;

class FormAddWorker extends StatefulWidget {
  const FormAddWorker({super.key});

  @override
  State<FormAddWorker> createState() => _FormAddWorkerState();
}

class _FormAddWorkerState extends State<FormAddWorker> {
  final _formKey = GlobalKey<FormState>();
  final _lastnameFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _messageFocusNode = FocusNode();
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  Future<void> insertrecord() async {
    if (_nameController.text.isNotEmpty &&
        _lastnameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty) {
      try {
        String uri = "http://192.168.1.69/garageparrot_api/insert_record.php";

        var  res = await http.post(Uri.parse(uri), body: {
          "name": _nameController.text,
          "lastname": _lastnameController.text,
          "email": _emailController.text,
          "phone": _phoneController.text
        });
        print("Réponse du serveur : ${res.body}");

        if (res.statusCode != 200) {
          print("Erreur lors de la connexion au serveur");
          return;
        }
        try {
          var response = jsonDecode(res.body);
          if (response["success"] == "true") {
            print("Employé créé avec succès");
          } else {
            print("Erreur lors de la création de l'employé");
          }
        } catch (e) {
          print("erreur de décodage JSON: $e");
        } 
        } catch (e) {
        print("erreur de requête: $e");
      } 
      } else {
        print("Veuillez remplir tous les champs");
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
              customFocus: _nameFocusNode,
              customRequestFocus: _lastnameFocusNode,
            ),
            const SizedBox(height: 10),
            CustomField(
              controller: _lastnameController,
              context: context,
              customLabel: "Prénom",
              customHintText: "Veuillez entrer votre prénom",
              customFocus: _lastnameFocusNode,
              customRequestFocus: _emailFocusNode,
            ),
            const SizedBox(height: 10),
            CustomField(
              controller: _emailController,
              context: context,
              customLabel: "Email",
              customHintText: "Veuillez entrer son email",
              customFocus: _emailFocusNode,
              customRequestFocus: _phoneFocusNode,
            ),
            const SizedBox(height: 10),
            CustomField(
              controller: _phoneController,
              context: context,
              customLabel: "Téléphone",
              customHintText: "Veuillez entrer votre téléphone",
              customFocus: _phoneFocusNode,
              customRequestFocus: _messageFocusNode,
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