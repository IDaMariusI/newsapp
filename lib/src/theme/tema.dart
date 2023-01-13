import 'package:flutter/material.dart';

const Color myColor = Colors.red;
final ThemeData darkTheme = ThemeData.dark();

final myTheme = darkTheme.copyWith(
  colorScheme: darkTheme.colorScheme.copyWith(secondary: myColor),
);
