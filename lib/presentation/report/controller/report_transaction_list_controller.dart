import 'package:hmj_apps/core/extension/date_extension.dart';
import 'package:hmj_apps/model/transaction_model.dart';
import 'package:hmj_apps/presentation/report/controller/report_base_controller.dart';

class ReportTransactionListController
    extends ReportBaseController<List<TransactionModel>> {
  @override
  List<FilterMode> get filters => [
        FilterMode.today,
        FilterMode.thisMonth,
        if (now.month != 1) FilterMode.lastMonth,
        FilterMode.selectMonth,
      ];

  @override
  List<TransactionModel> getLast7DaysReport() {
    throw UnimplementedError();
  }

  @override
  List<TransactionModel> getLastMonthReport() {
    return allDatas
        .where(
          (p0) => p0.date.month - 1 == now.month,
        )
        .toList();
  }

  @override
  List<TransactionModel> getLasy30DaysReport() {
    throw UnimplementedError();
  }

  @override
  List<TransactionModel> getSelectMonthReport({
    int? month,
  }) {
    return allDatas
        .where((p0) => p0.date.month == (month ?? selectedMonth.value))
        .toList();
  }

  @override
  List<TransactionModel> getSelectRangeDayReport() {
    throw UnimplementedError();
  }

  @override
  List<TransactionModel> getSelectRangeMonthReport({int? month}) {
    throw UnimplementedError();
  }

  @override
  List<TransactionModel> getThisMonthReport() {
    return allDatas
        .where(
          (p0) => p0.date.isThisMonth(),
        )
        .toList();
  }

  @override
  List<TransactionModel> getTodayReport() {
    return allDatas
        .where(
          (p0) => p0.date.isToday(),
        )
        .toList();
  }

  @override
  List<TransactionModel> getYesterdayReport() {
    throw UnimplementedError();
  }
}
