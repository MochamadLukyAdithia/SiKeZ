// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:get/get.dart';
// import 'package:hmj_apps/core/theme/app_color_theme.dart';

// enum Mode {
//   light,
//   dark,
// }

// extension on Mode {
//   bool get isLight => this == Mode.light;
//   bool get isDark => this == Mode.dark;
// }

// class ThemeController extends GetxController {
//   ThemeController(
//       {required DarkAppTheme darkAppTheme,
//       required LightAppTheme lightAppTheme})
//       : _darkAppTheme = darkAppTheme,
//         _lightAppTheme = lightAppTheme;

//   final DarkAppTheme _darkAppTheme;
//   final LightAppTheme _lightAppTheme;

//   static ThemeController find = Get.find();

//   final Rx<Mode> _appMode = Mode.light.obs;
//   Mode get appMode => _appMode.value;

//   AppColorTheme get theme => appMode.isDark ? _darkAppTheme : _lightAppTheme;
//   AppColorTheme get darkAppTheme => _darkAppTheme;
//   AppColorTheme get lightAppTheme => _lightAppTheme;

//   void setTheme(Mode newMode) {
//     _appMode.value = newMode;
//     update();
//   }

//   @override
//   void onInit() {
//     checkDeviceBrightness();
//     super.onInit();
//   }

//   void checkDeviceBrightness() {
//     var brightness =
//         SchedulerBinding.instance.platformDispatcher.platformBrightness;
//     setTheme(brightness == Brightness.dark ? Mode.dark : Mode.light);
//   }

//   void changeTheme() {
//     if (appMode.isLight) {
//       setTheme(Mode.dark);
//     } else if (appMode.isDark) {
//       setTheme(Mode.light);
//     }
//     log("CHANGED APP THEME: $appMode");
//   }
// }
