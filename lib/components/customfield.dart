import 'package:flutter/material.dart';

/// Widget personnalisé pour un champ de texte avec étiquette et indication.
class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.controller,
    //required this.context,
    required this.customLabel,
    required this.customHintText,
    required this.customFocus,
    required this.customRequestFocus,
    this.maxLines = 1,
  });

  //final BuildContext context;
  final TextEditingController controller;
  final String customLabel;
  final String customHintText;
  final FocusNode customFocus;
  final FocusNode customRequestFocus;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      focusNode: customFocus,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
        labelText: customLabel,
        labelStyle: Theme.of(context).textTheme.labelLarge,
        hintText: customHintText,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // vérifie que le champ n'est pas vide
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "veuillez remplir le champ";
        } return null;  
      },

      // permet de passer au champ de texte suivant
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(customRequestFocus);
      },
    );
  }
}
