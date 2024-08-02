import 'package:get/get.dart';
import 'package:hmj_apps/presentation/auth/controller/auth_binding.dart';
import 'package:hmj_apps/presentation/auth/screen/login/login_screen.dart';
import 'package:hmj_apps/presentation/dasboard/screen/dashboard_screen.dart';
import 'package:hmj_apps/presentation/profile/screen/profile_screen.dart';

class AppRoute {
  static const loginPage = "/";

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoute.loginPage,
      page: () => const ProfileScreen(),
      // binding: AuthBinding(),
    ),
  ];
}
