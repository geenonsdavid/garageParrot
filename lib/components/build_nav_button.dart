// Méthode pour créer un bouton de navigation
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_parrot/themes/colors.dart';

// Construit un bouton de navigation
// paramètres :
// - iconPath : chemin de l'icône
// - label : texte du bouton
// - isScreenPhone : détermine si l'écran est un téléphone
// - context : contexte de l'application
// - onPressed : fonction appelée lorsqu'on appuie sur le bouton
// - iconPhoneSize : taille de l'icône pour un téléphone
// - iconWebSize : taille de l'icône pour un ordinateur


Widget buildNavButton(
    String iconPath,
    String label,
    bool isScreenPhone,
    BuildContext context,
    VoidCallback onPressed,
    double iconSize,
    ) {
  return isScreenPhone
      ? MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SvgPicture.asset(
                iconPath,
                height: iconSize,
                width: iconSize,
                colorFilter:
                    const ColorFilter.mode(secondary, BlendMode.srcIn),
              ),
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
                  height: iconSize,
                  width: iconSize,
                  colorFilter:
                      const ColorFilter.mode(secondary, BlendMode.srcIn),
                ),
                Text(label, style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
          ),
        );
}
