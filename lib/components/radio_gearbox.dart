import 'package:flutter/material.dart';

class RadioGearbox extends StatefulWidget {
  const RadioGearbox({super.key});

  @override
  State<RadioGearbox> createState() => _RadioGearboxState();
}
class _RadioGearboxState extends State<RadioGearbox> {
  String? selectedGearbox;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
      children: [
        Text('Type de boite :',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Colors.black
        ),
        ),
      ],
    ),
        Row(
          children: [
            Radio(value: "automatic", groupValue: selectedGearbox, onChanged: (String? value) {
                    setState(() {
                      selectedGearbox = value;
                    });
                  }),
            const Text('Automatique'),
          ],
        ),
        Row(
          children: [
            Radio(value: "manual", groupValue: selectedGearbox, onChanged: (String? value) {
                    setState(() {
                      selectedGearbox = value;
                    });
                  }),
            const Text('Manuelle'),
          ],
        ),
      ],
    );
  }
}