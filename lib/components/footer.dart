import 'package:flutter/material.dart';
import 'package:garage_parrot/components/formcontact.dart';
import 'package:garage_parrot/components/line.dart';
import 'package:garage_parrot/components/timesopen.dart';
import 'package:garage_parrot/homepage.dart';
import 'package:garage_parrot/themes/colors.dart';

import 'phone_number.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
    required this.widget,
    required this.isScreenPhone,
  });

  final HomePage widget;
  final bool isScreenPhone;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary,
      child: Column(
        children: [
          // contact section
          Column(
            children: [
              Text('Nous contacter',
                  style: Theme.of(context).textTheme.headlineMedium),
              const PhoneSection(),
              const SizedBox(
                height: 8,
              ),
              const FormContact()
            ],
          ),
          const Line(),
          // widget TimesOpen for show times open
          const TimesOpen(
            openingHours: [
              {'day': 'Lundi', 'hours': '9h - 12h / fermé'},
              {'day': 'Mardi', 'hours': '9h - 12h / 14h - 19h'},
              {'day': 'Mercredi', 'hours': '9h - 12h / 14h - 19h'},
              {'day': 'Jeudi', 'hours': '9h - 12h / 14h - 19h'},
              {'day': 'Vendredi', 'hours': '9h - 12h / 14h - 19h'},
              {'day': 'Samedi', 'hours': '9h - 12h / 14h - 19h'},
              {'day': 'Dimanche', 'hours': 'fermé'},
            ],
          )
        ],
      ),
    );
  }
}