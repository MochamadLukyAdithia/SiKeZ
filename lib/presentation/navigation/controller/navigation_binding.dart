import 'package:get/get.dart';
import 'package:hmj_apps/core/injector/injector.dart';
import 'package:hmj_apps/presentation/dasboard/controller/dashboard_controller.dart';
import 'package:hmj_apps/presentation/navigation/controller/navigation_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_journal_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_transaction_list_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<NavigationController>());
    Get.put(getIt<ReportController>());
    Get.put(DashboardController());
    Get.put(ReportTransactionListController());
    Get.put(ReportJournalController());
  }
}
