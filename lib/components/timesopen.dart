import 'package:flutter/material.dart';
import 'package:garage_parrot/themes/colors.dart';

class TimesOpen extends StatefulWidget {
  const TimesOpen
({super.key});

  @override
  State<TimesOpen> createState() => _TimesOpenState();
}

class _TimesOpenState extends State<TimesOpen> {
  @override
  Widget build(BuildContext context) {
    String mondayAm = "9h - 12h";
    String mondayPm = "fermé";
    String tuesdayAm = mondayAm;
    String tuesdayPm = "14h - 19h";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          
          children: [
            Text("horaire d'ouverture",style: Theme.of(context).textTheme.headlineMedium,),
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
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Lundi : '),
                        Text('$mondayAm / $mondayPm'),
                            
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Mardi : '),
                        Text('$tuesdayAm / $tuesdayPm'),
                      ],
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Mercredi : '),
                        Text('$tuesdayAm / $tuesdayPm'),
                      ],
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Jeudi : '),
                        Text('$tuesdayAm / $tuesdayPm'),
                      ],
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Vendredi : '),
                        Text('$tuesdayAm / $tuesdayPm'),
                            
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Samedi : '),
                        Text('$tuesdayAm / $tuesdayPm'),
                            
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Dimanche : '),
                        Text('$mondayPm / $mondayPm'),
                            
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}