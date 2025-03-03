import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_parrot/components/build_nav_button.dart';
import 'package:garage_parrot/themes/colors.dart';
import 'package:garage_parrot/views/admin_view.dart';
import 'package:garage_parrot/views/homepage.dart';
import 'package:garage_parrot/views/shop_view.dart';
import 'package:provider/provider.dart';
import 'package:garage_parrot/models/user_model.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    Key? key,
    required this.title,
    required this.isScreenPhone,
    required this.userRole,
  }) : super(key: key);

  final String title;
  final bool isScreenPhone;
  final String userRole;

  @override
  Size get preferredSize => Size.fromHeight(isScreenPhone ? 80 : 152);

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  void _logout(BuildContext context) {
    // Réinitialiser le rôle à "guest" pour signaler la déconnexion
    Provider.of<UserModel>(context, listen: false).setUserRole("guest");

    // Redirection vers la page d'accueil après déconnexion
    Navigator.pushReplacementNamed(context, '/home');
  }

void _navigateToAdmin(BuildContext context, UserModel userModel) {
  if (userModel.userRole == "admin") {
    _navigateTo(context, AdminView(title: title));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Accès réservé aux administrateurs')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    double iconSize = 20;

    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        bool isLoggedIn = userModel.userRole != "guest"; // Vérifie si l'utilisateur est connecté

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
              Text(
                title,
                style: isScreenPhone
                    ? Theme.of(context).textTheme.headlineSmall
                    : Theme.of(context).textTheme.headlineLarge,
              ),
              Row(
                children: [
                  if (!isScreenPhone)
                    Text(
                      isLoggedIn ? 'Déconnexion' : 'Connexion',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  IconButton(
                    onPressed: () =>
                        isLoggedIn ? _logout(context) : Navigator.pushNamed(context, '/login'),
                    icon: SvgPicture.asset(
                      'assets/icons/power-off-solid.svg',
                      height: 24,
                      width: 24,
                      colorFilter: const ColorFilter.mode(secondary, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
                    () => _navigateTo(context, HomePage(title: title)),
                    iconSize,
                  ),
                  buildNavButton(
                    'assets/icons/car-on-solid.svg',
                    'Galerie',
                    isScreenPhone,
                    context,
                    () => _navigateTo(context, ShopView(title: title)),
                    iconSize,
                  ),
                  buildNavButton(
                    'assets/icons/admin.svg',
                    'Administrateur',
                    isScreenPhone,
                    context,
                    () => _navigateToAdmin(context, userModel),
                    iconSize,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
