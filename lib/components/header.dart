import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:garage_parrot/themes/colors.dart";

import '../homepage.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    super.key,
    required this.widget,
    required this.isScreenPhone
  });

  final HomePage widget;
  final bool isScreenPhone;

  @override
  // height of header
  Size get preferredSize => const Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    

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
              height: isScreenPhone ? 30 : 0,
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
                    'assets/logo_garage_parrot.png',
                    height: isScreenPhone ? 50 : 100,
                    width: isScreenPhone ? 50 : 100,
                  ),
                  Text(widget.title, style: Theme.of(context).textTheme.headlineLarge),
                  Row(
                    children: [
                      // button connexion
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/icons/power-off-solid.svg',
                          colorFilter:
                              const ColorFilter.mode(secondary, BlendMode.srcIn),
                        ),
                      ),
                      isScreenPhone
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
                  isScreenPhone ?
                  Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/house-solid.svg',
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
                        'assets/icons/house-solid.svg',
                        height: 30,
                        width: 30,
                        colorFilter: const ColorFilter.mode(
                            secondary, BlendMode.srcIn),
                      ),

                      Text('Accueil', style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                  // Galerie
                  isScreenPhone ?
                  Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/car-on-solid.svg',
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
                        'assets/icons/car-on-solid.svg',
                        height: 30,
                        width: 30,
                        colorFilter: const ColorFilter.mode(
                            secondary, BlendMode.srcIn),
                      ),

                      Text('Galerie', style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                  // Admin
                  isScreenPhone ?
                  Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/admin.svg',
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
                        'assets/icons/admin.svg',
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
