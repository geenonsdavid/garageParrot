import 'package:flutter/material.dart';
import 'package:garage_parrot/themes/colors.dart';

class TimesOpen extends StatefulWidget {
  const TimesOpen({
    Key? key,
    required this.openingHours,
  }) : super(key: key);

  final List<Map<String, String>> openingHours;

  @override
  State<TimesOpen> createState() => _TimesOpenState();
}

class _TimesOpenState extends State<TimesOpen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "Horaire d'ouverture",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: secondary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: widget.openingHours
                    .map((entry) => buildOpeningHoursRow(entry['day']!, entry['hours']!))
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildOpeningHoursRow(String day, String hours) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$day : '),
          Text(hours),
        ],
      ),
    );
  }
}
