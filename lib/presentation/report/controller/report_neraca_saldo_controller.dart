import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_buku_controller.dart';

class NeracaSaldoController extends BaseController {
  var dataBukuBesar =
      Get.find<BukuBesarController>().getTransactionAccountHistoryData();

  @override
  void onInit() {
    // TODO: implement onInit
    getBukuBesarAllSaldoTotal();
    super.onInit();
  }

  getBukuBesarAllSaldoTotal() {
    RxList listAllSaldoTotal = [
      // {
      //   "nama":"",
      //   "kode":"",
      //   "debit":0,
      //   "kredit":0
      // }
      ].obs;

    
  }
}
