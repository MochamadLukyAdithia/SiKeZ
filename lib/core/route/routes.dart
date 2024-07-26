import 'package:get/get.dart';
import 'package:hmj_apps/presentation/auth/controller/auth_binding.dart';
import 'package:hmj_apps/presentation/auth/screen/login_screen.dart';

class AppRoute {
  static const loginPage = "/";

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoute.loginPage,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
  ];
}
