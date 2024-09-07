import 'package:get/get.dart';
import 'package:hmj_apps/core/injector/injector.dart';
import 'package:hmj_apps/presentation/dasboard/controller/dashboard_controller.dart';
import 'package:hmj_apps/presentation/navigation/controller/navigation_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_buku_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_jurnal_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_laba_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_modal_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_neraca_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_neraca_saldo_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<NavigationController>());
    Get.put(getIt<ReportController>());
    Get.put(DashboardController());
    // Get.lazyPut(() => ReportJurnalController());
    // Get.lazyPut(() => BukuBesarController());
    // Get.lazyPut(() => NeracaSaldoController());
    // Get.lazyPut(() => ReportLabaRugiController());
    // Get.lazyPut(() => ReportModalController());
    // Get.lazyPut(() => ReportNeracaController());
  }
}
