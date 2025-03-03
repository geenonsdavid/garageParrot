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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final Validator validator = Validator();
  final ApiService apiservice = ApiService();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
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
                  if (value.length < 6) {
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : _buildSubmitButton("Connexion", _onSubmit),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(String label, VoidCallback onSubmit) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.task_alt),
      onPressed: _isLoading ? null : onSubmit, // Désactiver le bouton si en chargement
      label: Text(label),
    );
  }

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Activer le chargement
      });

      try {
        bool success = await apiservice.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        if (success) {
          if (mounted) {
            Provider.of<UserModel>(context, listen: false).setUserRole("admin");
            Navigator.pushNamed(context, '/admin');
          }
        } else {
          _showErrorDialog("Email ou mot de passe incorrect");
        }
      } catch (e) {
        _showErrorDialog("Une erreur s'est produite : ${e.toString()}");
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false; // Désactiver le chargement
          });
        }
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Erreur"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
