import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFFD3ECA7);
  static const secondaryColor = Color(0xFFA1B57D);
  static const tertiaryColor = Color(0xFFB33030);
  static const quaternaryColor = Color(0xFF4D1515);
  static const borderColor = Color(0xFFAEAEAE);
  static const lightGrey = Color(0xFFB8B8B8);

  static const primaryGradient = LinearGradient(
    colors: [
      tertiaryColor,
      quaternaryColor,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const secondaryGradient = LinearGradient(
    colors: [
      Colors.white,
      lightGrey,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const tertiaryGradient = LinearGradient(
    colors: [
      AppColors.primaryColor,
      AppColors.secondaryColor,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const quaternaryGradient = LinearGradient(
    colors: [
      AppColors.secondaryColor,
      Color(0xff464F37),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
