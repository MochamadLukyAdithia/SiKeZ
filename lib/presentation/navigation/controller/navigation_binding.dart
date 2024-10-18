import 'package:get/get.dart';
// import 'package:hmj_apps/core/injector/injector.dart';
import 'package:hmj_apps/presentation/dasboard/controller/dashboard_controller.dart';
import 'package:hmj_apps/presentation/navigation/controller/navigation_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_book_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_journal_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_laba_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_modal_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_neraca_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_neraca_saldo_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_transaction_list_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      NavigationController(),
    );
    Get.put(
      ReportController(),
    );
    Get.put(
      DashboardController(),
    );
    Get.put(
      ReportTransactionListController(),
    );
    Get.put(
      ReportJournalController(),
    );
    Get.put(
      ReportBookController(),
    );
    Get.put(
      ReportNeracaSaldoController(),
    );
    Get.put(
      ReportLabaController(),
    );
    Get.put(
      ReportModalController(),
    );
    Get.put(
      ReportNeracaController(),
    );
  }
}
