
import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/model/transaction_model.dart';
import 'package:hmj_apps/presentation/report/controller/report_controller.dart';
import 'package:intl/intl.dart';

class BukuBesarController extends BaseController {
  RxList<TransactionModel> transactionList =
      Get.find<ReportController>().reportTransactionList;
  RxList transactionListFilter = [].obs;

  @override
  void onInit() {
    var bukubesarData = getTransactionAccountHistoryData();
    for (var data in bukubesarData) {
      transactionListFilter.add(data["history"]);
    }
    // transactionListFilter.value = getTransactionAccountHistoryData();

    super.onInit();
  }

  void getBukuTransactionInAMonth() {
    // log(transactionListFilter[0][0]["date"].toString());
    transactionListFilter.value = transactionListFilter.where((p0) {
      return DateFormat("dd MMMM yyyy").parse(p0[0]["date"]).isAfter(
              DateTime.now().subtract(Duration(days: DateTime.now().month))) &&
          DateFormat("dd MMMM yyyy")
              .parse(p0[0]["date"])
              .isBefore(DateTime.now());
    }).toList();
  }

  void getBukuTransactionInAPreivousMonth() {
    transactionListFilter.value = transactionListFilter
        .where(
          (p0) =>
              DateFormat("dd MMMM yyyy")
                  .parse(p0[0]["date"])
                  .isAfter(DateTime(DateTime.now().year - 1, 12, 1)) &&
              DateFormat("dd MMMM yyyy").parse(p0[0]["date"]).isBefore(
                  DateTime(DateTime.now().year, DateTime.now().month, 1)
                      .subtract(const Duration(seconds: 1))),
        )
        .toList();
  }

  int getSumHistoryNominalData(List<Map<String, dynamic>> dataHistory) {
    // var historyList = bukuBesarData[idx]["history"];
    var historyList = dataHistory;
    var saldoTotal = 0;
    for (var data in historyList) {
      // log("debit ${data["debit"]} kredit ${data["kredit"]}");
      if (data["debit"] == 0) {
        saldoTotal -= int.parse(data["kredit"].toString());
      } else {
        saldoTotal += int.parse(data["debit"].toString());
      }
    }
    // log(saldoTotal.toString());

    return saldoTotal;
  }

  RxList getTransactionAccountHistoryData() {
    RxList bukuBesarData = [].obs;

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
    // transactionList.value = bukuBesarData;
    return bukuBesarData;
  }
}
