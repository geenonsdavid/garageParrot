import 'dart:ui';

import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData theme = ThemeData.light().copyWith(
  colorScheme:const  ColorScheme.light(
      primary: primary,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 24,
      fontFamily: 'comic',
      fontWeight: FontWeight.bold,
      color: secondary,
      shadows: [Shadow(
        color: Colors.black.withOpacity(0.25),
        offset: const Offset(4, 4),
        blurRadius: 4,

      )]
    ),
    titleMedium: const TextStyle(
      fontSize: 20,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: secondary,
    ),
    titleSmall: const TextStyle(
      fontSize: 18,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: secondary,
    ),

    labelSmall: const TextStyle(
      fontSize: 18,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: secondary,
    ),
  ),
);
