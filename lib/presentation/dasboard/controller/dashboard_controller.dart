import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/core/extension/date_extension.dart';
import 'package:hmj_apps/model/transaction_model.dart';
// import 'package:hmj_apps/presentation/report/controller/report_neraca_controller.dart';

class DashboardController extends BaseController {
  final Rx<DateTime> _selectedDate = DateTime.now().obs;

  DateTime get selectedDate => _selectedDate.value;

  // Rx<int> totalAset =
  //     Get.find<ReportNeracaController>().allTotal?["kas"] != null
  //         ? Get.find<ReportNeracaController>().allTotal!["kas"]!.obs
  //         : 0.obs;

  set setSelectedDate(DateTime dateTime) {
    _selectedDate.value = dateTime;
    update();
  }

  RxList<TransactionModel> transactionList = <TransactionModel>[].obs;

  List<TransactionModel> get getTransactionList {
    List<TransactionModel> tempList = [];
    for (int i = 0; i < transactionList.length; i++) {
      if (transactionList[i].date.isSameDate(selectedDate)) {
        transactionList[i].index = i;
        tempList.add(transactionList[i]);
      }
    }

    return tempList;
    // return transactionList.where((p) {
    //   return p.date.year == selectedDate.year &&
    //       p.date.month == selectedDate.month &&
    //       p.date.day == selectedDate.day;
    // }).toList();
  }

  @override
  void onInit() {
    getTransactions(fromInit: true);
    super.onInit();
  }

  getTransactions({bool fromInit = false}) async {
    try {
      if (!fromInit) showLoading();
      final result = await firestore
          .collection('transactions')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      List<TransactionModel> tempTransactionList = [];
      for (var i in result.data()?['data'] ?? []) {
        tempTransactionList.add(TransactionModel.fromJson(i));
      }
      tempTransactionList.sort((a, b) => a.date.compareTo(b.date));
      transactionList.value = tempTransactionList;
    } on FirebaseException catch (e) {
      showErrorToast(msg: e.message);
    } catch (e) {
      showErrorToast(msg: "Terjadi kesalahan. $e");
    } finally {
      if (!fromInit) Get.back();
    }
  }

  removeTransaction(int index) async {
    try {
      log("REMOVE TRANSACTION WITH ${transactionList[index].id} ID");

      await firestore
          .collection('transactions')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        "data": FieldValue.arrayRemove(
          [transactionList[index].toJson()],
        ),
      });

      transactionList.removeAt(index);
    } on FirebaseException catch (e) {
      showErrorToast(msg: e.message);
    } catch (e) {
      showErrorToast(msg: "Terjadi kesalahan. $e");
    }
  }
}
