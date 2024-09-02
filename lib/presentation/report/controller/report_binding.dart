import 'package:get/get.dart';
import 'package:hmj_apps/presentation/report/controller/report_buku_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_jurnal_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_laba_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_modal_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_neraca_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_neraca_saldo_controller.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportJurnalController());
    Get.lazyPut(() => BukuBesarController());
    Get.lazyPut(() => NeracaSaldoController());
    Get.lazyPut(() => ReportLabaRugiController());
    Get.lazyPut(() => ReportModalController());
    Get.lazyPut(() => ReportNeracaController());
  }
}
