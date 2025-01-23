import 'package:flutter/material.dart';
import 'package:garage_parrot/views/login_view.dart';

void onLogoutPressed(context) {
  // define what happens when the user logs out
    debugPrint('User logged out');
  // redirige vers view de connexion
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => const LoginView(),
    ),
  );
}