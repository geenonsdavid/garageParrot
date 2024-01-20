import 'package:flutter/material.dart';



class RadioDoor extends StatefulWidget {
  const RadioDoor({super.key});

  @override
  State<RadioDoor> createState() => _RadioDoorState();
}

class _RadioDoorState extends State<RadioDoor> {
  int? selectedDoor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Nombre de portes :',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.black
            ),
            ),
          ],
        ),
        Row(
          children: [
            Radio(value: 2,
            groupValue: selectedDoor,
            onChanged: (int? value) {
                    setState(() {
                      selectedDoor = value;
                    });
                  }),
            const Text('2'),
          ],
        ),
        Row(
          children: [
            Radio(value: 3,
            groupValue: selectedDoor,
            onChanged: (int? value) {
                    setState(() {
                      selectedDoor = value;
                    });
                  }),
            const Text('3'),
          ],
        ),
        Row(
          children: [
            Radio(value: 4,
            groupValue: selectedDoor,
            onChanged: (int? value) {
                    setState(() {
                      selectedDoor = value;
                    });
                  }),
            const Text('4'),
          ],
        ),
        Row(
          children: [
            Radio(value: 5,
            groupValue: selectedDoor,
            onChanged: (int? value) {
                    setState(() {
                      selectedDoor = value;
                    });
                  }),
            const Text('5'),
          ],
        ),
      ],
    );
  }
}
