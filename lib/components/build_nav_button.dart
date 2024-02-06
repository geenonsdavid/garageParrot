// Méthode pour créer un bouton de navigation
  import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_parrot/themes/colors.dart';

Widget buildNavButton(String iconPath, String label, bool isScreenPhone, BuildContext context) {
    return isScreenPhone
        ? Column(
            children: [
              SvgPicture.asset(
                iconPath,
                height: 30,
                width: 30,
                colorFilter: const ColorFilter.mode(secondary, BlendMode.srcIn),
              ),
              Text(label, style: Theme.of(context).textTheme.headlineMedium),
            ],
          )
        : Row(
            children: [
              SvgPicture.asset(
                iconPath,
                height: 30,
                width: 30,
                colorFilter: const ColorFilter.mode(secondary, BlendMode.srcIn),
              ),
              Text(label, style: Theme.of(context).textTheme.headlineMedium),
            ],
          );
  }
