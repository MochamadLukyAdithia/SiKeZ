import 'package:hmj_apps/core/extension/date_extension.dart';
import 'package:hmj_apps/model/transaction_model.dart';
import 'package:hmj_apps/presentation/report/controller/report_base_controller.dart';

class ReportJournalController
    extends ReportBaseController<List<TransactionModel>> {
  @override
  List<FilterMode> get filters => [
        FilterMode.today,
        FilterMode.yesterday,
        FilterMode.last7Days,
        FilterMode.last30Days,
        FilterMode.thisMonth,
        if (now.month != 1) FilterMode.lastMonth,
        FilterMode.selectRangeDate,
        FilterMode.selectRangeMonth,
      ];

  @override
  List<TransactionModel> getLast7DaysReport() {
    return allDatas.where((p0) {
      return p0.date.simplified
          .isAfter(now.subtract(const Duration(days: 7)).simplified);
    }).toList();
  }

  @override
  List<TransactionModel> getLastMonthReport() {
    return allDatas.where((p0) => p0.date.month - 1 == now.month).toList();
  }

  @override
  List<TransactionModel> getLasy30DaysReport() {
    return allDatas.where((p0) {
      return p0.date.simplified
          .isAfter(now.subtract(const Duration(days: 30)).simplified);
    }).toList();
  }

  @override
  List<TransactionModel> getSelectMonthReport({
    int? month,
  }) {
    return allDatas
        .where((p0) => p0.date.month == selectedMonth.value)
        .toList();
  }

  @override
  List<TransactionModel> getSelectRangeDayReport() {
    return allDatas
        .where((p0) =>
            p0.date.isAfter(firstRangedDate.value) &&
            p0.date.isBefore(
                secondRangedDate.value.subtract(const Duration(days: -1))))
        .toList();
  }

  @override
  List<TransactionModel> getSelectRangeMonthReport({int? month}) {
    return allDatas
        .where((p0) =>
            p0.date.month >= firstRangedMonth.value &&
            p0.date.month <= secondRangedMonth.value)
        .toList();
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
    return allDatas
        .where(
            (p0) => p0.date.isSameDate(now.subtract(const Duration(days: 1))))
        .toList();
  }
}
