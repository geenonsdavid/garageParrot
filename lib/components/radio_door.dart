import 'package:flutter/material.dart';
import 'package:garage_parrot/providers/caracteristic_provider.dart';
import 'package:provider/provider.dart';

class RadioDoor extends StatefulWidget {
  const RadioDoor({Key? key}) : super(key: key);
  @override
  State<RadioDoor> createState() => _RadioDoorState();
}

class _RadioDoorState extends State<RadioDoor> {
  late CaracteristicProvider caracteristicProvider;

  @override
  void initState() {
    super.initState();
    caracteristicProvider = Provider.of<CaracteristicProvider>(context, listen: false);
  }

  int? selectedDoor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Nombre de portes :',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black,
                  ),
            ),
          ],
        ),
        Column(
          children: [
            for (int i = 2; i <= 5; i++)
              Row(
                children: [
                  Radio(
                    value: i,
                    groupValue: selectedDoor,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDoor = value;
                        caracteristicProvider.updateSelectedDoor(selectedDoor);
                      });
                    },
                  ),
                  Text('$i'),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
