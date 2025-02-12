import 'package:flutter/material.dart';
import 'package:garage_parrot/themes/colors.dart';

/// Widget personnalisé pour un champ de texte avec étiquette et indication.
class CustomField extends StatefulWidget {
  const CustomField({
    super.key,
    required this.controller,
    //required this.context,
    required this.customLabel,
    required this.customHintText,
    required this.customFocus,
    required this.customRequestFocus,
    this.validator,
    this.maxLines = 1,
    this.obscureText = false,
  });

  //final BuildContext context;
  final TextEditingController controller;
  final String customLabel;
  final String customHintText;
  final FocusNode customFocus;
  final FocusNode customRequestFocus;
  final String? Function(String?)? validator;
  final int maxLines;
  final bool obscureText;

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  /// Contrôle la visibilité du texte (mot de passe)
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      focusNode: widget.customFocus,
      obscureText: _isObscured,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
        labelText: widget.customLabel,
        labelStyle: Theme.of(context).textTheme.labelLarge,
        hintText: widget.customHintText,
        // Ajoute l'icône pour afficher/masquer le mot de passe
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: primary,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                tooltip: _isObscured
                    ? "Afficher le mot de passe"
                    : "Masquer le mot de passe",
              )
            : null,
      ),
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // vérifie que le champ n'est pas vide
      validator: widget.validator,

      // permet de passer au champ de texte suivant
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(widget.customRequestFocus);
      },
    );
  }
}
