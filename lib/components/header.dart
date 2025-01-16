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
  Size get preferredSize => Size.fromHeight(isScreenPhone ? 80 : 152);

  @override
  Widget build(BuildContext context) {
    double iconSize = 20;
    return AppBar(
      backgroundColor: primary,
      toolbarHeight: preferredSize.height,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo_garage_parrot.png',
            height: isScreenPhone ? 30 : 100,
            width: isScreenPhone ? 30 : 100,
          ),
          // Titre de l'application
          Text(
            title,
            style: isScreenPhone
                ? Theme.of(context).textTheme.headlineSmall
                : Theme.of(context).textTheme.headlineLarge,
          ),
          // Bouton de déconnexion
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
                  height: 24,
                  width: 24,
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
      // Barre de navigation
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(isScreenPhone ? 20 : 48),
        child: Padding(
          padding: EdgeInsets.all(isScreenPhone ? 2 : 8),
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
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          HomePage(title: title),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                iconSize,
              ),
              buildNavButton(
                'assets/icons/car-on-solid.svg',
                'Galerie',
                isScreenPhone,
                context,
                () {
                  // Naviguer vers la page de la galerie
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ShopView(title: title),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                iconSize,
              ),
              buildNavButton(
                'assets/icons/admin.svg',
                'Administrateur',
                isScreenPhone,
                context,
                () {
                  // Naviguer vers la page d'administrateur
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AdminView(title: title),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                iconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
