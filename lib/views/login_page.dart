import 'package:flutter/material.dart';
import 'package:garage_parrot/components/customfield.dart';
import 'package:garage_parrot/src/utils/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Déclaration de TextEditingController pour gérer les champs
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();

  final FocusNode passwordFocus = FocusNode();

  final Validator validator = Validator();

  // Clé du formulaire
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Libération des ressources
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomField(
                controller: emailController,
                customLabel: "Email",
                customHintText: "Veuillez saisir votre email",
                customFocus: emailFocus,
                customRequestFocus: passwordFocus,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir votre email';
                  }
                  return validator.verifyEmail(value);
                },
              ),
              CustomField(
                controller: passwordController,
                customLabel: "Mot de passe",
                customHintText: "Veuillez saisir votre mot de passe",
                customFocus: passwordFocus,
                customRequestFocus: passwordFocus,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le mot de passe';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                child: const Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
