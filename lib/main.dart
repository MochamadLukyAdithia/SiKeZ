import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/injector/injector.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/core/theme/app_color_theme.dart';
import 'package:hmj_apps/core/theme/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  Get.put(ThemeController(
      darkAppTheme: DarkAppTheme(), lightAppTheme: LightAppTheme()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        getPages: AppRoute.routes);
  }
}
