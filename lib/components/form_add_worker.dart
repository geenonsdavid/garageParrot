import 'package:flutter/material.dart';
import 'package:garage_parrot/components/customfield.dart';
import 'package:garage_parrot/themes/colors.dart';

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
  final _messageController = TextEditingController();

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
        borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
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
              controller : _phoneController,
              context: context,
              customLabel: "Téléphone",
              customHintText: "Veuillez entrer votre téléphone",
              customFocus: _phoneFocusNode,
              customRequestFocus: _messageFocusNode,
            ),
            const SizedBox(height: 10),
            CustomField(
              controller : _messageController,
              context: context,
              customLabel: "Message",
              customHintText: "Veuillez entrer votre message",
              customFocus: _messageFocusNode,
              customRequestFocus: _messageFocusNode,
              maxLines: 4,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.task_alt),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // send form at administrator email
                  submit();
                }
              },
              label: const Text("Envoyez"),
            ),
          ],
        ),
      ),
    );
  }

  void submit() {
    // Affiche les valeurs saisies
    debugPrint('Nom: ${_nameController.text}');
    debugPrint('Prénom: ${_lastnameController.text}');
    debugPrint('Email: ${_emailController.text}');
    debugPrint('Téléphone : ${_phoneController.text}');
    debugPrint('Message: ${_messageController.text}');
    

  }
}
