import 'package:flutter/material.dart';

class RadioFuel extends StatefulWidget {
  const RadioFuel({super.key});

  @override
  State<RadioFuel> createState() => _RadioFuelState();
}

class _RadioFuelState extends State<RadioFuel> {
  String? selectedFuel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Row(
        children: [
          Text(
            'Type de carburant :',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.black),
          ),
        ],
      ),
      Row(
          children: [
            Radio(value: "Diesel", groupValue: selectedFuel, onChanged: (String? value) {
                    setState(() {
                      selectedFuel = value;
                    });
                  }),
            const Text('Diesel'),
          ],
        ),
      Row(
          children: [
            Radio(value: "essence", groupValue: selectedFuel, onChanged: (String? value) {
                    setState(() {
                      selectedFuel = value;
                    });
                  }),
            const Text('Essence'),
          ],
        ),
      Row(
          children: [
            Radio(value: "hybribe", groupValue: selectedFuel, onChanged: (String? value) {
                    setState(() {
                      selectedFuel = value;
                    });
                  }),
            const Text('hybride'),
          ],
        ),
      Row(
          children: [
            Radio(value: "electrique", groupValue: selectedFuel, onChanged: (String? value) {
                    setState(() {
                      selectedFuel = value;
                    });
                  }),
            const Text('Electrique'),
          ],
        ),
      Row(
          children: [
            Radio(value: "gpl", groupValue: selectedFuel, onChanged: (String? value) {
                    setState(() {
                      selectedFuel = value;
                    });
                  }),
            const Text('GPL'),
          ],
        ),
      Row(
          children: [
            Radio(value: "autre", groupValue: selectedFuel, onChanged: (String? value) {
                    setState(() {
                      selectedFuel = value;
                    });
                  }),
            const Text('Autre'),
          ],
        ),
    ]);
  }
}
