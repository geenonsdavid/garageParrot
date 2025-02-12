import 'package:flutter/material.dart';
import 'package:garage_parrot/components/customfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // Déclaration de TextEditingController pour gérer les champs
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomField(
                controller: usernameController,
                customLabel: "Nom",
                customHintText: "Veuillez saisir votre nom",
                customFocus: usernameFocus,
                customRequestFocus: passwordFocus),
            CustomField(
              controller: passwordController,
              customLabel: "Mot de passe",
              customHintText: "Veuillez saisir votre mot de passe",
              customFocus: passwordFocus,
              customRequestFocus: passwordFocus,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Vérification des champs
                if (usernameController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Erreur"),
                        content: const Text("Veuillez remplir tous les champs."),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Afficher un message d'erreur si les champs sont vides
                  // Par exemple, naviguer vers la page d'accueil ou vérifier les informations d'identification
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: const Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
