import 'dart:developer';

import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/model/transaction_model.dart';
import 'package:hmj_apps/presentation/report/controller/report_controller.dart';

class ReportJurnalController extends BaseController {
  RxList<TransactionModel> transactionList = <TransactionModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getTransactionData();
    super.onInit();
  }

  void getTransactionData() {
    transactionList.value = Get.find<ReportController>().reportTransactionList;
    log("get transaction data ${transactionList.length}");
  }
}
