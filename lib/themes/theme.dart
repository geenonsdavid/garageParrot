import 'dart:ui';

import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData theme = ThemeData.light().copyWith(
  colorScheme:const  ColorScheme.light(
      primary: primary,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 32,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: secondary,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      color: secondary,
    ),
    labelSmall: TextStyle(
      fontSize: 20,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      color: secondary,
    ),
  ),
);
