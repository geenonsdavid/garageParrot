import 'package:flutter/material.dart';

class SwitchOption extends StatefulWidget {
  const SwitchOption({
    Key? key,
    required this.nameOption,
    required this.onChanged, // Ajout de la fonction de rappel onChanged
  }) : super(key: key);

  final String nameOption;
  final ValueChanged<bool> onChanged; // Déclaration de la fonction de rappel onChanged

  @override
  State<SwitchOption> createState() => _SwitchOptionState();
}

class _SwitchOptionState extends State<SwitchOption> {
  bool optionCar = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: optionCar,
          onChanged: (bool value) {
            setState(() {
              optionCar = value;
            });

            // Appeler la fonction de rappel onChanged pour informer le parent du changement
            widget.onChanged(value);
          },
        ),
        Text(widget.nameOption),
      ],
    );
  }

  // Fonction pour récupérer l'état d'optionCar à l'extérieur
  //bool getOptionCarState() {
  //  return optionCar;
  //}
}
