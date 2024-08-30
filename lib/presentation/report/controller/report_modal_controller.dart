import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_laba_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_neraca_saldo_controller.dart';
import 'package:hmj_apps/presentation/report/model/neraca_saldo_model.dart';

class ReportModalController extends BaseController {
  RxList<NeracaSaldo> dataNeracaSaldo = <NeracaSaldo>[].obs;
  int totalLabaBersih = Get.find<ReportLabaRugiController>().countLaba();
  RxMap<String, int>? itemDisplayData;

  @override
  void onInit() {
    // TODO: implement onInit\
    dataNeracaSaldo =
        Get.find<NeracaSaldoController>().getBukuBesarAllSaldoTotal();
    itemDisplayData = getCountPerubahanModal();
    super.onInit();
  }

  getCountPerubahanModal() {
    int penambahanModal = 0;
    int prive = 0;

    for (var data in dataNeracaSaldo) {
      if (data.kode == "3-1100") {
        penambahanModal += (data.debit != 0 ? data.debit : data.kredit).abs();
      }
      if (data.kode == "3-1200") {
        prive += (data.debit != 0 ? data.debit : data.kredit).abs();
      }
    }

    return {"modal": penambahanModal, "prive": prive}.obs;
  }
}
