import 'package:get/get.dart';
import 'package:hmj_apps/presentation/auth/controller/auth_binding.dart';
import 'package:hmj_apps/presentation/auth/screen/login_screen.dart';
import 'package:hmj_apps/presentation/dasboard/screen/dashboard_screen.dart';
import 'package:hmj_apps/presentation/navigation/controller/navigation_binding.dart';
import 'package:hmj_apps/presentation/navigation/screen/navigation_scree.dart';
import 'package:hmj_apps/presentation/report/screen/report_detail_screen.dart';
import 'package:hmj_apps/presentation/report/screen/report_list_screen.dart';
import 'package:hmj_apps/presentation/transaction/screen/add_transaction_screen.dart';

class AppRoute {
  static const loginPage = "/";
  static const navigation = "/navigation";
  static const dashboardPage = "/dashboard";
  static const addTransaction = "/transaction/add";
  static const detailReport = "/report/detail";
  static const reportList = "/report/list";

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
    GetPage(
        name: AppRoute.navigation,
        page: () => const NavigationScreen(),
        binding: NavigationBinding()),
    GetPage(
      name: AppRoute.detailReport,
      page: () => const ReportDetailScreen(),
    ),
        GetPage(
      name: AppRoute.reportList,
      page: () => const ReportListScreen(),
    ),
  ];
}
