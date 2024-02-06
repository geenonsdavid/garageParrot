// Méthode pour créer un bouton de navigation
  import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_parrot/themes/colors.dart';

Widget buildNavButton(
  String iconPath,
  String label,
  bool isScreenPhone,
  BuildContext context,
  VoidCallback onPressed,// aadd param manage event
  ) {
    return isScreenPhone
        ? MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onPressed,
            child: Column(
                children: [
                  SvgPicture.asset(
                    iconPath,
                    height: 30,
                    width: 30,
                    colorFilter: const ColorFilter.mode(secondary, BlendMode.srcIn),
                  ),
                  Text(label, style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
          ),
        )
        : MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onPressed,
            child: Row(
                children: [
                  SvgPicture.asset(
                    iconPath,
                    height: 30,
                    width: 30,
                    colorFilter: const ColorFilter.mode(secondary, BlendMode.srcIn),
                  ),
                  Text(label, style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
          ),
        );
  }
