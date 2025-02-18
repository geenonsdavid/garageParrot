import 'package:flutter/material.dart';

void showSuccessDialog(context,String message) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Succès"),
      content: Text(message),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}

void showErrorDialog(context,String message) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Erreur"),
      content: Text(message),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}
