import 'package:flutter/material.dart';

class AppColorTheme {
  AppColorTheme({
    required this.backgroundColor,
    required this.navigationColor,
    required this.primaryTextColor,
  });
  final Color primaryColor = const Color(0xFFCB982B);
  final Color secondaryColor = const Color(0xFFF2C573);

  final Grey grey = Grey();
  final Danger danger = Danger();
  final Done done = Done();
  final Gradient gradient = Gradient();
  final Color backgroundColor;
  final Color navigationColor;
  final Color primaryTextColor;
}

class Gradient {
  final LinearGradient shade1 = const LinearGradient(
    colors: [
      Color(0xFFF5B01D),
      Color(0xFFE39B02),
    ],
  );
}

class LightAppTheme extends AppColorTheme {
  LightAppTheme({
    Color backgroundColor = const Color(0xFFFFFFFF),
    Color navigationColor = const Color(0xFFFFFFFF),
    Color primaryTextColor = const Color(0xFF303030),
  }) : super(
          backgroundColor: backgroundColor,
          navigationColor: navigationColor,
          primaryTextColor: primaryTextColor,
        );
}

class DarkAppTheme extends AppColorTheme {
  DarkAppTheme({
    Color backgroundColor = const Color(0xFF1D1D1D),
    Color navigationColor = const Color(0xFF2C2C2C),
    Color primaryTextColor = const Color(0xFFFFFFFF),
  }) : super(
          backgroundColor: backgroundColor,
          navigationColor: navigationColor,
          primaryTextColor: primaryTextColor,
        );
}

class Grey {
  final Color shade1 = const Color(0xFF9E9E9E);
  final Color shade2 = const Color(0xFFD9D9D9);
  final Color shade3 = const Color(0xFF383838);
}

class Danger {
  final Color shade1 = const Color(0xFFD11427);
}

class Done {
  final Color shade1 = const Color(0xFF599D15);
}
