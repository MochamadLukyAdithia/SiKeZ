import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/model/transaction_model.dart';
import 'package:intl/intl.dart';

class ReportController extends BaseController {
  final Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;

  set setSelectedDate(DateTime dateTime) {
    _selectedDate.value = dateTime;
    getTransactions();
  }

  @override
  void onInit() {
    getTransactions(fromInit: true);
    super.onInit();
  }

  RxList<TransactionModel> reportTransactionList = <TransactionModel>[].obs;

  final filterDateFull = [
    "Kemarin",
    "7 Hari Terakhir",
    "30 Hari Terakhir",
    "Bulan ini",
    "Bulan lalu",
    "Pilih range hari",
    "Pilih range bulan"
  ];
  final filterDateMonth = ["Bulan ini", "Bulan lalu", "Pilih bulan"];
  final filterDateonly = ["Pilih Tanggal"];

  RxString choosedFilter = "01".obs;

  changeDate(String filterText) {
    choosedFilter.value = filterText;
  }

  String displayChoosedDate(int numberOfDay) {
    return DateFormat.yMd()
        .format(DateTime.now().subtract(Duration(days: numberOfDay)));
  }

  List chosedFilterListForPage(String pageName) {
    if (pageName == "jurnal" || pageName == "labaRugi") {
      return filterDateFull;
    } else if (pageName == "neracaSaldo" || pageName == "bukuBesar") {
      return filterDateMonth;
    } else {
      return filterDateonly;
    }
  }

  getTransactions({bool fromInit = false}) async {
    try {
      if (!fromInit) showLoading();
      final result = await firestore
          .collection('transactions')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      List<TransactionModel> tempreportTransactionList = [];
      for (var i in result.data()?['data'] ?? []) {
        tempreportTransactionList.add(TransactionModel.fromJson(i));
      }
      reportTransactionList.value = tempreportTransactionList;
    } on FirebaseException catch (e) {
      showErrorToast(msg: e.message);
    } catch (e) {
      showErrorToast(msg: "Terjadi kesalahan. $e");
    } finally {
      if (!fromInit) Get.back();
    }
  }
}
