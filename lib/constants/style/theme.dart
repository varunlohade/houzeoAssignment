import 'package:contacts/constants/style/custom_color.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: CustomColor.lightModePrimary,
      fontFamily: 'Inter',
      
      textTheme: const TextTheme(
        displayMedium: TextStyle(
            color: CustomColor.lightModeTextColor,
            fontSize: 60,
            fontWeight: FontWeight.normal),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: CustomColor.darkModePrimary,
      textTheme: const TextTheme(
        displayMedium: TextStyle(
            color: CustomColor.darkModeTextColor,
            fontSize: 60,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
