import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/model/transaction_model.dart';
import 'package:hmj_apps/presentation/report/controller/report_controller.dart';
import 'package:intl/intl.dart';

class BukuBesarController extends BaseController {
  RxList<TransactionModel> transactionList =
      Get.find<ReportController>().reportTransactionList;

  RxList bukuBesarData = [
    {
      "account": "Pendapata",
      "history": [
        {
          "date": "31 jul 2024",
          "debit": [1000],
          "kredit": [0],
          "saldo": 10000
        },
      ]
    },
  ].obs;

  @override
  void onInit() {
    // getTransactionAccountHistoryData();
    super.onInit();
  }

  getTransactionAccountHistoryData() async {
    for (var i = 0; i < transactionList.length; i++) {
      var existingAccount = bukuBesarData.firstWhere(
        (element) => element["account"] == transactionList[i].debitName,
        orElse: () => {"account": "kosong", "history": []},
      );
      if (existingAccount["account"] == "kosong") {
        log("data Kosong");
        bukuBesarData.add({
          "account": transactionList[i].debitName,
          "history": [
            {
              "date":
                  DateFormat('dd MMMM yyyy').format(transactionList[i].date),
              "debit": [transactionList[i].nominal],
              "kredit": [0],
              "saldo": 10000
            },
          ]
        });
      } else {
        log("debit ada = ${existingAccount["account"]}");
        var idx = bukuBesarData.indexWhere(
            (element) => element["account"] == existingAccount["account"]);

        bukuBesarData[idx]["history"].add(
          {
            "date": DateFormat('dd MMMM yyyy').format(transactionList[i].date),
            "debit": [transactionList[i].nominal],
            "kredit": [0],
            "saldo": 10000
          },
        );
    
      }

      var existingKreditAccount = bukuBesarData.firstWhere(
        (element) => element["account"] == transactionList[i].creditName,
        orElse: () => {"account": "kosong", "history": []},
      );
      if (existingKreditAccount["account"] == "kosong") {
        log("data Kosong");
        bukuBesarData.add({
          "account": transactionList[i].creditName,
          "history": [
            {
              "date":
                  DateFormat('dd MMMM yyyy').format(transactionList[i].date),
              "debit": [0],
              "kredit": [transactionList[i].nominal],
              "saldo": 10000
            },
          ]
        });
      } else {
        log("kredit ada = ${existingKreditAccount["account"]}");
        var idx = bukuBesarData.indexWhere((element) =>
            element["account"] == existingKreditAccount["account"]);

        bukuBesarData[idx]["history"].add(
          {
            "date": DateFormat('dd MMMM yyyy').format(transactionList[i].date),
            "debit": [0],
            "kredit": [transactionList[i].nominal],
            "saldo": 10000
          },
        );
        // if (transactionList[i].debitName == existingAccount["account"]) {
        //   log("${transactionList[i].debitName} == ${existingAccount["account"]}");
        //   log("kredit nya sama");
        // } else {
        //   log("${transactionList[i].debitName} != ${existingAccount["account"]}");
        // }
        // log("data ada ${existingAccount.toString()}");
      }
      log(bukuBesarData.toString());
      // var data = bukuBesarData[0]["history"][0]["debit"][0];
      // log("cek data ${bukuBesarData.where((p0) => p0["account"] == "kas").indexed}");
      // bukuBesarData.add(element)
      // var data = transactionList[1].debitName;
      // log(data.toString());
    }
  }
}
