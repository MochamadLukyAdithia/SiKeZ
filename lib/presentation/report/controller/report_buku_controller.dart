import 'dart:developer';

import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/model/transaction_model.dart';
import 'package:hmj_apps/presentation/report/controller/report_controller.dart';
import 'package:intl/intl.dart';

class BukuBesarController extends BaseController {
  RxList<TransactionModel> transactionList =
      Get.find<ReportController>().reportTransactionList;

  RxList bukuBesarData = [
    // {
    // "account": "Pendapata",
    // "history": [
    //   {
    //     "date": "31 jul 2024",
    //     "debit": [1000],
    //     "kredit": [0],
    //     "saldo": 10000
    //   },
    // ]
    // },
  ].obs;

  @override
  void onInit() {
    getTransactionAccountHistoryData();
    super.onInit();
  }

  int getSumHistoryNominalData(idx) {
    var historyList = bukuBesarData[idx]["history"];
    var saldoTotal = 0;
    for (var data in historyList) {
      log("debit ${data["debit"]} kredit ${data["kredit"]}");
      if (data["debit"] == 0) {
        saldoTotal -= int.parse(data["kredit"].toString());
      } else {
        saldoTotal += int.parse(data["debit"].toString());
      }
    }
    log(saldoTotal.toString());

    return saldoTotal;
  }

  getTransactionAccountHistoryData() async {
    for (var i = 0; i < transactionList.length; i++) {
      var existingAccount = bukuBesarData.firstWhere(
        (element) => element["account"] == transactionList[i].debitName,
        orElse: () => {"account": "kosong", "history": []},
      );
      if (existingAccount["account"] == "kosong") {
        // log("data Kosong");
        bukuBesarData.add({
          "account": transactionList[i].debitName,
          "account_number": transactionList[i].debitCode,
          "history": [
            {
              "date":
                  DateFormat('dd MMMM yyyy').format(transactionList[i].date),
              "debit": transactionList[i].nominal,
              "kredit": 0,
              "saldo": 10000
            },
          ]
        });
      } else {
        // log("debit ada = ${existingAccount["account"]}");
        var idx = bukuBesarData.indexWhere(
            (element) => element["account"] == existingAccount["account"]);

        bukuBesarData[idx]["history"].add(
          {
            "date": DateFormat('dd MMMM yyyy').format(transactionList[i].date),
            "debit": transactionList[i].nominal,
            "kredit": 0,
            "saldo": 10000
          },
        );
      }

      var existingKreditAccount = bukuBesarData.firstWhere(
        (element) => element["account"] == transactionList[i].creditName,
        orElse: () => {"account": "kosong", "history": []},
      );
      if (existingKreditAccount["account"] == "kosong") {
        // log("data Kosong");
        bukuBesarData.add({
          "account": transactionList[i].creditName,
          "account_number": transactionList[i].creditCode,
          "history": [
            {
              "date":
                  DateFormat('dd MMMM yyyy').format(transactionList[i].date),
              "debit": 0,
              "kredit": transactionList[i].nominal,
              "saldo": 10000
            },
          ]
        });
      } else {
        // log("kredit ada = ${existingKreditAccount["account"]}");
        var idx = bukuBesarData.indexWhere((element) =>
            element["account"] == existingKreditAccount["account"]);

        bukuBesarData[idx]["history"].add(
          {
            "date": DateFormat('dd MMMM yyyy').format(transactionList[i].date),
            "debit": 0,
            "kredit": transactionList[i].nominal,
            "saldo": 10000
          },
        );
      }
      // log(bukuBesarData.toString());
    }
  }
}
