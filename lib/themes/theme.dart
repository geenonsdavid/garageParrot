import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData.light().copyWith(
  colorScheme: const ColorScheme.light(
    primary: primary,
  ),
  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    // h1 : size 24 bold
    headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: secondary,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(4, 4),
            blurRadius: 4,
          )
        ]),
    // h2: size 20 bold
    headlineMedium: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: secondary,
    ),
    // h3: size 18 bold
    headlineSmall: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: secondary,
    ),
    // link : size 20 normal
    labelLarge: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: secondary,
    ),
    // texte16: size 16 normal
    bodyLarge: const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    textStyle: TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    padding: const EdgeInsets.all(8),
    backgroundColor: primary,
    foregroundColor: secondary, // Utilisez onPrimary pour définir la couleur du texte
    shape: RoundedRectangleBorder(
      side: const BorderSide(
        color: secondary,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(50),
    ),
  ),
),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.all(8),
  )
);