import 'package:flutter/material.dart';
import 'package:garage_parrot/models/user_model.dart';
import 'package:garage_parrot/views/admin_view.dart';
import 'package:garage_parrot/views/homepage.dart';
import 'package:garage_parrot/themes/theme.dart';
import 'package:garage_parrot/views/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context)=>UserModel(),
      child: const MyApp(),
      )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final String title = 'Garage V. Parrot';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: theme,
      home: HomePage(title: title),
      initialRoute: '/home',  // Route initiale
      routes: {
        '/home': (context) => HomePage(title: title),
        '/login': (context) => const LoginPage(), 
        '/admin' : (context) =>  const AdminView(title: "Admin page"),// Route vers la page de connexion
      },
    );
  }
}


