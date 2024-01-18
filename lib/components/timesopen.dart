import 'package:flutter/material.dart';

class TimesOpen extends StatefulWidget {
  const TimesOpen
({super.key});

  @override
  State<TimesOpen> createState() => _TimesOpenState();
}

class _TimesOpenState extends State<TimesOpen> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: [
              Text("horaire d'ouverture"),
            ],
          ),
        ),
      ],
    );
  }
}