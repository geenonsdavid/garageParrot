import 'package:flutter/material.dart';
import 'package:garage_parrot/components/customfield.dart';
import 'package:garage_parrot/themes/colors.dart';

// Define a custom Form widget.
class FormContact extends StatefulWidget {
  const FormContact({super.key});

  @override
  FormContactState createState() {
    return FormContactState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class FormContactState extends State<FormContact> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  String email = "";
  String name = "";
  String lastname = "";
  String phoneNumber = "";
  String message = "";
  final _formKey = GlobalKey<FormState>();
  final _nameFocusNode = FocusNode();
  final _lastnameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _messageFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            width: 1,
            color: secondary,
          )),
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(maxWidth: 300),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Formulaire de contact',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                // Add TextFormFields and ElevatedButton here.
                CustomField(
                  context: context,
                  customLabel: "nom",
                  customHintText: "Veuillez entrer votre nom",
                  customFocus: _nameFocusNode,
                  customRequestFocus: _lastnameFocusNode,
                  onValueChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                CustomField(
                  context: context,
                  customLabel: "Prénom",
                  customHintText: "Veuillez entrer votre prénom",
                  customFocus: _lastnameFocusNode,
                  customRequestFocus: _emailFocusNode,
                  onValueChanged: (value) {
                    setState(() {
                      lastname = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                CustomField(
                  context: context,
                  customLabel: "Email",
                  customHintText: "Veuillez entrer votre email",
                  customFocus: _emailFocusNode,
                  customRequestFocus: _phoneFocusNode,
                  onValueChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                CustomField(
                  context: context,
                  customLabel: "Téléphone",
                  customHintText: "Veuillez entrer votre téléphone",
                  customFocus: _phoneFocusNode,
                  customRequestFocus: _messageFocusNode,
                  onValueChanged: (value) {
                    setState(() {
                      phoneNumber = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                CustomField(
                  context: context,
                  customLabel: "Message",
                  customHintText: "Veuillez entrer votre message",
                  customFocus: _messageFocusNode,
                  customRequestFocus: _messageFocusNode,
                  onValueChanged: (value) {
                    setState(() {
                      message = value;
                    });
                  },
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
        ],
      ),
    );
  }

  void submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Envoie réussi')),
    );
  }
}
