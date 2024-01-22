import 'package:flutter/material.dart';
import 'package:garage_parrot/homepage.dart';
import 'package:garage_parrot/providers/caracteristic_provider.dart';
import 'package:garage_parrot/themes/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CaracteristicProvider()),
        // Ajoutez d'autres fournisseurs si nécessaire
      ],
      child: const MyApp(),
    ),
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
    );
  }
}


