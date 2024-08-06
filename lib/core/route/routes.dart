import 'package:get/get.dart';
import 'package:hmj_apps/presentation/auth/controller/auth_binding.dart';
import 'package:hmj_apps/presentation/auth/screen/login_screen.dart';
import 'package:hmj_apps/presentation/dasboard/screen/dashboard_screen.dart';
import 'package:hmj_apps/presentation/transaction/screen/add_transaction_screen.dart';

class AppRoute {
  static const loginPage = "/";
  static const dashboardPage = "/dashboard";
  static const addTransaction = "/transaction/add";

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoute.loginPage,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoute.dashboardPage,
      page: () => const DashboardSceen(),
    ),
    GetPage(
      name: AppRoute.addTransaction,
      page: () => const AddTransactionScreen(),
    ),
  ];
}
