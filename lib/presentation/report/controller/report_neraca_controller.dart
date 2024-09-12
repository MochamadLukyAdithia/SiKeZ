import 'dart:developer';

import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_neraca_saldo_controller.dart';
import 'package:hmj_apps/presentation/report/model/neraca_model.dart';
import 'package:hmj_apps/presentation/report/model/neraca_saldo_model.dart';

class ReportNeracaController extends BaseController {
  RxList<NeracaSaldo> dataTotal =
      Get.find<NeracaSaldoController>().getBukuBesarAllSaldoTotal();

  RxList<Neraca> allDataNeraca = <Neraca>[].obs;
  Map<String, int>? allTotal;

  @override
  void onInit() {
    allDataNeraca = getAllNeracaDataItem();
    allTotal = countAllTotal();
    super.onInit();
  }

  countAllTotal() {
    final Map<String, int> allTotal = {
      "kas": 0,
      "hutang": 0,
      "modal": 0,
      "all": 0
    };

    List<Neraca> kas =
        allDataNeraca.where((item) => item.kode[0] == "1").toList();
    List<Neraca> hutang =
        allDataNeraca.where((item) => item.kode[0] == "2").toList();
    List<Neraca> modal =
        allDataNeraca.where((item) => item.kode[0] == "3").toList();
    int totalKas = 0;
    int totalHutang = 0;
    int totalModal = 0;

    for (var itemKas in kas) {
      if (itemKas.kode == "1-2210" || itemKas.kode == "1-2310") {
        totalKas -= itemKas.nominal;
      } else {
        totalKas += itemKas.nominal;
      }
    }
    for (var itemHutang in hutang) {
      totalHutang += itemHutang.nominal;
    }
    for (var itemModal in modal) {
      totalModal += itemModal.nominal;
    }

    allTotal["kas"] = totalKas;
    allTotal["hutang"] = totalHutang;
    allTotal["modal"] = totalModal;
    allTotal["all"] = totalKas + totalHutang + totalModal;

    return allTotal;
  }

  getAllNeracaDataItem() {
    RxList<Neraca> dataItem = <Neraca>[].obs;

    for (var dataNeraca in dataTotal) {
      log(dataNeraca.kode[0].toString());
      if (dataNeraca.kode[0] == "1" ||
          dataNeraca.kode[0] == "2" ||
          dataNeraca.kode[0] == "3") {
        dataItem.add(Neraca(
            nama: dataNeraca.nama,
            kode: dataNeraca.kode,
            nominal:
                dataNeraca.debit <= 0 ? dataNeraca.kredit : dataNeraca.debit));
      }
    }

    return dataItem;
  }
}
