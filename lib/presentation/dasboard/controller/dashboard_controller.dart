import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/model/transaction_model.dart';
import 'package:intl/intl.dart';

class DashboardController extends BaseController {
  final Rx<DateTime> _selectedDate = DateTime.now().obs;

  DateTime get selectedDate => _selectedDate.value;

  set setSelectedDate(DateTime dateTime) {
    _selectedDate.value = dateTime;
    getTransactions();
  }

  RxList<TransactionModel> transactionList = <TransactionModel>[].obs;

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
          .collection(DateFormat("dd-MM-yyyy").format(selectedDate))
          .get();
      List<TransactionModel> tempTransactionList = [];
      for (var i in result.docs) {
        tempTransactionList.add(TransactionModel.fromJson(i.id, i.data()));
      }
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
      await firestore
          .collection('transactions')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection(DateFormat("dd-MM-yyyy").format(selectedDate))
          .doc(transactionList[index].id)
          .delete();

      transactionList.removeAt(index);
    } on FirebaseException catch (e) {
      showErrorToast(msg: e.message);
    } catch (e) {
      showErrorToast(msg: "Terjadi kesalahan. $e");
    }
  }
}
