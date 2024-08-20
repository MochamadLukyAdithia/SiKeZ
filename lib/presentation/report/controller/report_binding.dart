import 'package:get/get.dart';
import 'package:hmj_apps/presentation/report/controller/report_buku_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_jurnal_controller.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportJurnalController());
    Get.lazyPut(() => BukuBesarController());
  }
}
