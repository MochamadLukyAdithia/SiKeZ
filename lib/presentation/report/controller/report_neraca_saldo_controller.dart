import 'dart:developer';

import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_buku_controller.dart';
import 'package:hmj_apps/presentation/report/model/neraca_saldo_model.dart';

class NeracaSaldoController extends BaseController {
  var dataBukuBesar =
      Get.find<BukuBesarController>().getTransactionAccountHistoryData();

  @override
  void onInit() {
    // TODO: implement onInit
    getBukuBesarAllSaldoTotal();
    super.onInit();
  }

  Map<String, int> getTotalDebitKredit() {
    Map<String, int> total = {"debit": 0, "kredit": 0};
    int debit = 0;
    int kredit = 0;
    var dataAllSaldo = getBukuBesarAllSaldoTotal();

    for (var number in dataAllSaldo) {
      if (number.debit != 0) {
        debit += number.debit;
      } else {
        kredit += number.kredit;
      }
    }
    total["debit"] = debit;
    total["kredit"] = kredit;
    log(total.toString());
    return total;
  }

  RxList<NeracaSaldo> getBukuBesarAllSaldoTotal() {
    RxList<NeracaSaldo> listAllSaldoTotal = <NeracaSaldo>[].obs;

    for (var dataAkun in dataBukuBesar) {
      int saldoTotal = Get.find<BukuBesarController>()
          .getSumHistoryNominalData(dataAkun["history"]);
      if (saldoTotal < 0) {
        listAllSaldoTotal.add(NeracaSaldo(
            nama: dataAkun["account"],
            kode: dataAkun["account_number"],
            debit: 0,
            kredit: saldoTotal));
      } else {
        listAllSaldoTotal.add(NeracaSaldo(
            nama: dataAkun["account"],
            kode: dataAkun["account_number"],
            debit: saldoTotal,
            kredit: 0));
      }
    }
    return listAllSaldoTotal;
  }
}
