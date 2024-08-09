import 'package:get/get.dart';
import 'package:hmj_apps/presentation/auth/controller/auth_binding.dart';
import 'package:hmj_apps/presentation/auth/screen/login_screen.dart';
import 'package:hmj_apps/presentation/dasboard/screen/dashboard_screen.dart';
import 'package:hmj_apps/presentation/navigation/controller/navigation_binding.dart';
import 'package:hmj_apps/presentation/navigation/screen/navigation_scree.dart';
import 'package:hmj_apps/presentation/report/screen/detail_list/buku_screen.dart';
import 'package:hmj_apps/presentation/report/screen/detail_list/laba_screen.dart';
import 'package:hmj_apps/presentation/report/screen/detail_list/modal_screen.dart';
import 'package:hmj_apps/presentation/report/screen/detail_list/neraca_saldo_screen.dart';
import 'package:hmj_apps/presentation/report/screen/detail_list/neraca_screen.dart';
import 'package:hmj_apps/presentation/report/screen/report_detail_screen.dart';
import 'package:hmj_apps/presentation/report/screen/detail_list/jurnal_screen.dart';
import 'package:hmj_apps/presentation/transaction/screen/add_transaction_screen.dart';

class AppRoute {
  static const loginPage = "/";
  static const navigation = "/navigation";
  static const dashboardPage = "/dashboard";
  static const addTransaction = "/transaction/add";
  static const detailReport = "/report/detail";
  static const reporJurnaltList = "/report/list/jurnal";
  static const reportNeracaList = "/report/list/neraca";
  static const reportNearacaSaldoList = "/report/list/neracaSaldo";
  static const reportModalList = "/report/list/modal";
  static const reportLabaRugiList = "/report/list/labaRugi";
  static const reportBukuBesarList = "/report/list/bukuBesar";

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
      name: AppRoute.reporJurnaltList,
      page: () => const JurnalListScreen(),
    ),
    GetPage(
      name: AppRoute.reportNeracaList,
      page: () => const NeracaListScreen(),
    ),
    GetPage(
      name: AppRoute.reportNearacaSaldoList,
      page: () => const NeracaSaldoListScreen(),
    ),
    GetPage(
      name: AppRoute.reportModalList,
      page: () => const ModalListScreen(),
    ),
    GetPage(
      name: AppRoute.reportLabaRugiList,
      page: () => const LabaRugiListScreen(),
    ),
    GetPage(
      name: AppRoute.reportBukuBesarList,
      page: () => const BukuBesarListScreen(),
    ),
  ];
}
