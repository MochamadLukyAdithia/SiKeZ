// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:hmj_apps/model/transaction_model.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_base_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_transaction_list_controller.dart';

class BookModel {
  final String account;
  final String code;
  List<BookHistoryModel> history;

  BookModel({
    required this.code,
    required this.account,
    required this.history,
  });
}

class BookHistoryModel {
  final DateTime dateTime;
  final int debit;
  final int kredit;

  BookHistoryModel({
    required this.dateTime,
    required this.debit,
    required this.kredit,
  });
}

class ReportBookController extends ReportBaseController<List<BookModel>> {
  final transactionList = Get.find<ReportTransactionListController>();

  @override
  List<FilterMode> get filters => [
        FilterMode.today,
        FilterMode.thisMonth,
        FilterMode.lastMonth,
        FilterMode.selectMonth,
      ];

  @override
  List<BookModel> getLast7DaysReport() {
    throw UnimplementedError();
  }

  @override
  List<BookModel> getLastMonthReport() {
    final rawData = transactionList.getLastMonthReport();
    return getProccessedData(rawData);
  }

  @override
  List<BookModel> getLasy30DaysReport() {
    throw UnimplementedError();
  }

  @override
  List<BookModel> getSelectMonthReport({
    int? month,
  }) {
    final rawData =
        transactionList.getSelectMonthReport(month: selectedMonth.value);
    return getProccessedData(rawData);
  }

  @override
  List<BookModel> getSelectRangeDayReport({
    DateTime? firstDate,
    DateTime? secondDate,
  }) {
    throw UnimplementedError();
  }

  @override
  List<BookModel> getSelectRangeMonthReport({
    int? firstMonth,
    int? secondMonth,
  }) {
    throw UnimplementedError();
  }

  @override
  List<BookModel> getThisMonthReport() {
    final rawData = transactionList.getThisMonthReport();
    return getProccessedData(rawData);
  }

  @override
  List<BookModel> getTodayReport() {
    final rawData = transactionList.getTodayReport();
    return getProccessedData(rawData);
  }

  List<BookModel> getProccessedData(List<TransactionModel> rawData) {
    List<BookModel> tempList = [];
    for (var data in rawData) {
      final debitIndex =
          tempList.indexWhere((element) => element.account == data.debitName);

      final debitBookModel =
          BookHistoryModel(dateTime: data.date, debit: data.nominal, kredit: 0);
      if (debitIndex >= 0) {
        tempList[debitIndex].history.add(debitBookModel);
      } else {
        tempList.add(
          BookModel(
            code: data.debitCode,
            account: data.debitName,
            history: [debitBookModel],
          ),
        );
      }

      final creditBookIndex =
          tempList.indexWhere((element) => element.account == data.creditName);
      final creditBookModel =
          BookHistoryModel(dateTime: data.date, debit: 0, kredit: data.nominal);

      if (creditBookIndex >= 0) {
        tempList[creditBookIndex].history.add(creditBookModel);
      } else {
        tempList.add(
          BookModel(
            code: data.creditCode,
            account: data.creditName,
            history: [creditBookModel],
          ),
        );
      }
    }
    return tempList;
  }

  @override
  List<BookModel> getYesterdayReport() {
    throw UnimplementedError();
  }

  List<BookModel> getAllReport() {
    final rawData = transactionList.getTodayReport();
    return getProccessedData(rawData);
  }
}
