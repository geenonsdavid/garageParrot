import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:garage_parrot/themes/colors.dart";

import '../homepage.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    super.key,
    required this.widget,
    required this.currentWidth,
  });

  final HomePage widget;
  final double currentWidth;

  @override
  // height of header
  Size get preferredSize => const Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    double heightLogo;
    double widthLogo;
    bool screenPhone;
    // responsive logo
    if (currentWidth < 480) {
      screenPhone = true;
      heightLogo = 50;
      widthLogo = 50;
    } else {
      screenPhone = false;
      heightLogo = 100;
      widthLogo = 100;
    }

    return Container(
      color: primary,
      child: Column(
        children: [
          //SizeBox
          DecoratedBox(
            decoration: const BoxDecoration(
              color: primary,
            ),
            //navBar
            child: SizedBox(
              height: screenPhone ? 30 : 0,
              width: double.infinity,
            ),
          ),
          // title section
          Padding(
            padding: const EdgeInsets.only(left: 8.0,top:0,right: 8,bottom: 4),
            child: DecoratedBox(
              decoration: const BoxDecoration(color: primary),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'logo_garage_parrot.png',
                    height: heightLogo,
                    width: widthLogo,
                  ),
                  Text(widget.title, style: Theme.of(context).textTheme.headlineLarge),
                  Row(
                    children: [
                      // button connexion
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          '/icons/power-off-solid.svg',
                          colorFilter:
                              const ColorFilter.mode(secondary, BlendMode.srcIn),
                        ),
                      ),
                      screenPhone
                          ? const SizedBox.shrink()
                          : Text('Connexion',
                              style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // nav buttons
          Padding(
            padding: const EdgeInsets.only(left: 8.0,top:4,right: 8,bottom: 4),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Accueil
                  screenPhone ?
                  Column(
                    children: [
                      SvgPicture.asset(
                        'icons/house-solid.svg',
                        height: 30,
                        width: 30,
                        colorFilter: const ColorFilter.mode(
                            secondary, BlendMode.srcIn),
                      ),

                      Text('Accueil', style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ):
                  Row(
                    children: [
                      SvgPicture.asset(
                        'icons/house-solid.svg',
                        height: 30,
                        width: 30,
                        colorFilter: const ColorFilter.mode(
                            secondary, BlendMode.srcIn),
                      ),

                      Text('Accueil', style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                  // Galerie
                  screenPhone ?
                  Column(
                    children: [
                      SvgPicture.asset(
                        'icons/car-on-solid.svg',
                        height: 30,
                        width: 30,
                        colorFilter: const ColorFilter.mode(
                            secondary, BlendMode.srcIn),
                      ),

                      Text('Galerie', style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ):
                  Row(
                    children: [
                      SvgPicture.asset(
                        'icons/car-on-solid.svg',
                        height: 30,
                        width: 30,
                        colorFilter: const ColorFilter.mode(
                            secondary, BlendMode.srcIn),
                      ),

                      Text('Galerie', style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                  // Admin
                  screenPhone ?
                  Column(
                    children: [
                      SvgPicture.asset(
                        'icons/admin.svg',
                        height: 30,
                        width: 30,
                        colorFilter: const ColorFilter.mode(
                            secondary, BlendMode.srcIn),
                      ),

                      Text('Administrateur', style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ):
                  Row(
                    children: [
                      SvgPicture.asset(
                        'icons/admin.svg',
                        height: 30,
                        width: 30,
                        colorFilter: const ColorFilter.mode(
                            secondary, BlendMode.srcIn),
                      ),

                      Text('Administrateur', style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

  }
}
