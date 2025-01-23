import 'package:flutter/material.dart';
import 'package:garage_parrot/components/api_service.dart';
import 'package:garage_parrot/components/customfield.dart';
import 'package:garage_parrot/themes/colors.dart';


class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, String>> _fields = [

    {"label": "Email", "hintText": "Veuillez entrer son email"},
    {
      "label": "Password",
      "hintText": "Veuillez entrer le mot de passe"
    },
  ];

  late final _focusNodes =
      List.generate(_fields.length, (index) => FocusNode());
  late final _controllers =
      List.generate(_fields.length, (index) => TextEditingController());

  Widget _buildCustomField(int index, String label, String hintText) {
    return
    Column(
      children: [
        CustomField(
          controller: _controllers[index],
          context: context,
          customLabel: label,
          customHintText: hintText,
          customFocus: _focusNodes[index],
          customRequestFocus: index < _focusNodes.length - 1
              ? _focusNodes[index + 1]
              : FocusNode(),
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
            ..._buildCustomFields(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildSubmitButton("connexion",_onSubmit),],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(label,onSubmit) => ElevatedButton.icon(
        icon: const Icon(Icons.task_alt),
        onPressed: onSubmit,
        label: Text(label),
      );

  void _onSubmit() {
    if (_formKey.currentState!.validate()){}
    debugPrint("connexion");
    // récupérer les données du formulaire
    final data = {
      "email": _controllers[0].text,
      "password": _controllers[1].text,
    };
    // comparer avec les données de la base de données
    ApiService().login(data).then((value) {
      if (value) {
        // allez à la page admistrateur
        debugPrint("connexion réussie");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email ou mot de passe incorrect"),
          ),
        );
      }
    });
  }

  _buildCustomFields() =>
  List.generate(
        _fields.length,
        (index) => _buildCustomField(
            index, _fields[index]["label"]!, _fields[index]["hintText"]!),
      );
}
