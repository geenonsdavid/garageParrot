import 'package:flutter/material.dart';
import 'package:garage_parrot/providers/caracteristic_provider.dart';
import 'package:provider/provider.dart';

class RadioGearbox extends StatefulWidget {
  const RadioGearbox({super.key});

  @override
  State<RadioGearbox> createState() => _RadioGearboxState();
}

class _RadioGearboxState extends State<RadioGearbox> {
  String? selectedGearbox;
  late CaracteristicProvider caracteristicProvider;

  @override
  void initState() {
    super.initState();
    caracteristicProvider =
        Provider.of<CaracteristicProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Type de boite :',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
                value: "automatic",
                groupValue: selectedGearbox,
                onChanged: (String? value) {
                  setState(() {
                    selectedGearbox = value;
                    caracteristicProvider.updateSelectedGearbox(selectedGearbox);
                  });
                }),
            const Text('Automatique'),
          ],
        ),
        Row(
          children: [
            Radio(
                value: "manual",
                groupValue: selectedGearbox,
                onChanged: (String? value) {
                  setState(() {
                    selectedGearbox = value;
                    caracteristicProvider.updateSelectedGearbox(selectedGearbox);
                  });
                }),
            const Text('Manuelle'),
          ],
        ),
      ],
    );
  }
}
