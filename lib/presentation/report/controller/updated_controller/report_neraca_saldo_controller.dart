import 'package:get/get.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_base_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_book_controller.dart';

class NeracaSaldoModel {
  final String accountName;
  final String accountCode;
  final int debit;
  final int credit;

  NeracaSaldoModel({
    required this.accountName,
    required this.accountCode,
    required this.debit,
    required this.credit,
  });
}

class ReportNeracaSaldoController
    extends ReportBaseController<List<NeracaSaldoModel>> {
  @override
  List<FilterMode> get filters => [
        FilterMode.thisMonth,
        if (now.month != 1) FilterMode.lastMonth,
        FilterMode.selectMonth,
      ];

  @override
  void onInit() {
    currentFilter.value = FilterMode.thisMonth;
    super.onInit();
  }

  final ReportBookController reportBookController =
      Get.find<ReportBookController>();

  @override
  List<NeracaSaldoModel> getLast7DaysReport() {
    throw UnimplementedError();
  }

  @override
  List<NeracaSaldoModel> getLastMonthReport() {
    return getProccessedData(reportBookController.getLastMonthReport());
  }

  @override
  List<NeracaSaldoModel> getLasy30DaysReport() {
    throw UnimplementedError();
  }

  @override
  List<NeracaSaldoModel> getSelectMonthReport({int? month}) {
    return getProccessedData(
        reportBookController.getSelectMonthReport(month: selectedMonth.value));
  }

  @override
  List<NeracaSaldoModel> getSelectRangeDayReport({
    DateTime? firstDate,
    DateTime? secondDate,
  }) {
    throw UnimplementedError();
  }

  @override
  List<NeracaSaldoModel> getSelectRangeMonthReport({
    int? firstMonth,
    int? secondMonth,
  }) {
    throw UnimplementedError();
  }

  @override
  List<NeracaSaldoModel> getThisMonthReport() {
    return getProccessedData(reportBookController.getThisMonthReport());
  }

  @override
  List<NeracaSaldoModel> getTodayReport() {
    throw UnimplementedError();
  }

  List<NeracaSaldoModel> getProccessedData(List<BookModel> list) {
    List<NeracaSaldoModel> tempList = [];
    for (var data in list) {
      int debit = data.history
          .fold(0, (previousValue, element) => previousValue + element.debit);
      int credit = data.history
          .fold(0, (previousValue, element) => previousValue + element.kredit);

      tempList.add(
        NeracaSaldoModel(
            accountName: data.account,
            accountCode: data.code,
            debit: debit,
            credit: credit),
      );
    }
    return tempList;
  }

  @override
  List<NeracaSaldoModel> getYesterdayReport() {
    throw UnimplementedError();
  }
}
