import 'package:flutter/material.dart';
import 'package:garage_parrot/views/homepage.dart';
import 'package:garage_parrot/themes/theme.dart';

void main() {
  runApp(const MyApp());
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


