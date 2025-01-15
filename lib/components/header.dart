import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_parrot/components/build_nav_button.dart';
import 'package:garage_parrot/themes/colors.dart';
import 'package:garage_parrot/views/admin_view.dart';
import 'package:garage_parrot/views/homepage.dart';
import 'package:garage_parrot/views/shop_view.dart';

// En-tête de l'application
/// isScreenPhone : détermine si l'écran est un téléphone
/// onLogoutPressed : fonction appelée lorsqu'on appuie sur le bouton de déconnexion
class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    Key? key,
    required this.title,
    required this.isScreenPhone,
    this.onLogoutPressed,
  }) : super(key: key);

  final String title;
  final bool isScreenPhone;
  final VoidCallback? onLogoutPressed;

  @override
  // Taille préférée de l'en-tête
  Size get preferredSize => const Size.fromHeight(152);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primary,
      toolbarHeight: preferredSize.height,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo_garage_parrot.png',
            height: isScreenPhone ? 50 : 100,
            width: isScreenPhone ? 50 : 100,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          //if (!isScreenPhone)
          Row(
            children: [
              if (isScreenPhone != true)
                Text(
                  'Connexion',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              IconButton(
                onPressed: onLogoutPressed,
                icon: SvgPicture.asset(
                  'assets/icons/power-off-solid.svg',
                  colorFilter: const ColorFilter.mode(
                    secondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildNavButton(
                'assets/icons/house-solid.svg',
                'Accueil',
                isScreenPhone,
                context,
                () {
                  // Naviguer vers la page d'accueil
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(title: title)));
                },
              ),
              buildNavButton(
                'assets/icons/car-on-solid.svg',
                'Galerie',
                isScreenPhone,
                context,
                () {
                  // Naviguer vers la page de la galerie
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopView(title: title)));
                },
              ),
              buildNavButton(
                'assets/icons/admin.svg',
                'Administrateur',
                isScreenPhone,
                context,
                () {
                  // Naviguer vers la page d'administrateur
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminView(title: title)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
