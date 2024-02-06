import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:garage_parrot/components/build_nav_button.dart";
import "package:garage_parrot/themes/colors.dart";

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    super.key,
    required this.title,
    required this.isScreenPhone,
    this.onLogoutPressed,
  });

  final String title;
  final bool isScreenPhone;
  final VoidCallback? onLogoutPressed;

  @override
  // height of header
  Size get preferredSize => const Size.fromHeight(152);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary,
      child: Column(
        children: [
          //SizeBox
          SizedBox(
            height: isScreenPhone ? 20 : 8,
            width: double.infinity,
          ),
          // title section
          Padding(
            padding:
                const EdgeInsets.only(left: 8.0, top: 0, right: 8, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/logo_garage_parrot.png',
                  height: isScreenPhone ? 50 : 100,
                  width: isScreenPhone ? 50 : 100,
                ),
                Text(title,
                    style: Theme.of(context).textTheme.headlineLarge),
                Row(
                  children: [
                    // button connexion
                    IconButton(
                      onPressed: () {
                        //gérer l'évévement du bouton
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/power-off-solid.svg',
                        colorFilter: const ColorFilter.mode(
                          secondary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    if (!isScreenPhone)
                      Text(
                        'Connexion',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                  ],
                ),
              ],
            ),
          ),
          // nav buttons
          Padding(
            padding:
                const EdgeInsets.only(left: 8.0, top: 4, right: 8, bottom: 4),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Accueil
                  buildNavButton(
                    'assets/icons/house-solid.svg',
                    'Accueil',
                    isScreenPhone,
                    context,
                  ),
                  // Galerie
                  buildNavButton(
                    'assets/icons/car-on-solid.svg',
                    'Galerie',
                    isScreenPhone,
                    context,
                  ),
                  buildNavButton(
                    'assets/icons/admin.svg',
                    'Administrateur',
                    isScreenPhone,
                    context,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
