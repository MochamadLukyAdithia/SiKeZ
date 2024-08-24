import 'dart:developer';

import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/model/transaction_model.dart';
import 'package:hmj_apps/presentation/report/controller/report_controller.dart';
import 'package:intl/intl.dart';

class ReportJurnalController extends BaseController {
  RxList<TransactionModel> transactionList = <TransactionModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getTransactionData();
    super.onInit();
  }

  void getTransactionYesterday() {
    transactionList.value = Get.find<ReportController>()
        .reportTransactionList
        .where(
          (p0) =>
              DateFormat.yMMMd().format(p0.date) ==
              DateFormat.yMMMd()
                  .format(DateTime.now().subtract(Duration(days: 1))),
        )
        .toList();
  }

  void getTransactionThirtyDays() {
    transactionList.value = Get.find<ReportController>()
        .reportTransactionList
        .where(
          (p0) =>
              p0.date.isAfter(DateTime.now().subtract(Duration(days: 30))) &&
              p0.date.isBefore(DateTime.now().subtract(Duration(days: 1))),
        )
        .toList();
  }

  void getTransactionToday() {
    transactionList.value = Get.find<ReportController>()
        .reportTransactionList
        .where(
          (p0) =>
              DateFormat.yMMMd().format(p0.date) ==
              DateFormat.yMMMd().format(DateTime.now()),
        )
        .toList();
  }

  void getTransactionInAWeek() {
    transactionList.value = Get.find<ReportController>()
        .reportTransactionList
        .where(
          (p0) =>
              p0.date.isAfter(DateTime.now()
                  .subtract(Duration(days: DateTime.now().weekday))) &&
              p0.date.isBefore(DateTime.now()),
        )
        .toList();
  }

  void getTransactionInAMonth() {
    transactionList.value = Get.find<ReportController>()
        .reportTransactionList
        .where(
          (p0) =>
              p0.date.isAfter(DateTime.now()
                  .subtract(Duration(days: DateTime.now().month))) &&
              p0.date.isBefore(DateTime.now()),
        )
        .toList();
  }

  void getTransactionInAPreivousMonth() {
    transactionList.value = Get.find<ReportController>()
        .reportTransactionList
        .where(
          (p0) =>
              p0.date.isAfter(DateTime(DateTime.now().year - 1, 12, 1)) &&
              p0.date.isBefore(
                  DateTime(DateTime.now().year, DateTime.now().month, 1)
                      .subtract(const Duration(seconds: 1))),
        )
        .toList();
  }

  void getTransactionData() {
    transactionList.value = Get.find<ReportController>().reportTransactionList
      ..sort(
        (a, b) => b.date.compareTo(a.date),
      );

    log("get transaction data ${transactionList.length}");
  }
}
