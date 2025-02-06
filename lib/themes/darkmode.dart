import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: AppBarTheme(color: Colors.black),
  drawerTheme: DrawerThemeData(backgroundColor: Colors.black),
  textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
);
