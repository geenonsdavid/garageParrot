import 'package:flutter/material.dart';
import 'package:garage_parrot/services/api_service.dart';
import 'package:garage_parrot/components/customfield.dart';
import 'package:garage_parrot/models/user_model.dart';
import 'package:garage_parrot/src/utils/validator.dart';
import 'package:provider/provider.dart';

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

  final ApiService apiservice = ApiService();

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
                    // vérifier si l'email et le mot de passe son correcte dans la base de données
                    return 'Veuillez saisir le mot de passe';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildSubmitButton("Connexion", _onSubmit),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(label, onSubmit) => ElevatedButton.icon(
        icon: const Icon(Icons.task_alt),
        onPressed: onSubmit,
        label: Text(label),
      );

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        bool success = await apiservice.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        debugPrint("success = $success");
        if (success) {
          //_showSuccessDialog("Connexion réussie");
          // Définir le rôle de l'utilisateur en tant qu'admin
          
          if (mounted) {
            Provider.of<UserModel>(context, listen: false).setRole("admin");
            Navigator.pushNamed(context, '/admin');
          }
        } else {
          //showErrorDialog("Email ou mot de passe incorrect");
          throw Exception("Email ou mot de passe incorrect");
        }
      } catch (e) {
        //showErrorDialog("Une erreur s'est produite : $e");
        throw Exception("Une erreur s'est produite : $e");
      }
    }
  }
}
