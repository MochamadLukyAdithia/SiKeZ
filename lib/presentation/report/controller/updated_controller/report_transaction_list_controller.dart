import 'package:hmj_apps/core/extension/date_extension.dart';
import 'package:hmj_apps/model/transaction_model.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_base_controller.dart';

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
    List<TransactionModel> tempList = [];
    for (int i = 0; i < allDatas.length; i++) {
      if (allDatas[i].date.isAfter(
            now
                .subtract(
                  const Duration(days: 6),
                )
                .simplified,
          )) {
        tempList.add(allDatas[i].newWithIndex(i));
      }
    }
    return tempList;
    // return allDatas
    //     .where(
    //       (element) => element.date.isAfter(
    //         now
    //             .subtract(
    //               const Duration(days: 6),
    //             )
    //             .simplified,
    //       ),
    //     )
    //     .toList();
  }

  @override
  List<TransactionModel> getLastMonthReport() {
    List<TransactionModel> tempList = [];
    for (int i = 0; i < allDatas.length; i++) {
      if (allDatas[i].date.month == (now.month - 1)) {
        tempList.add(allDatas[i].newWithIndex(i));
      }
    }
    return tempList;
    // return allDatas
    //     .where(
    //       (p0) => p0.date.month == (now.month - 1),
    //     )
    //     .toList();
  }

  @override
  List<TransactionModel> getLasy30DaysReport() {
    List<TransactionModel> tempList = [];
    for (int i = 0; i < allDatas.length; i++) {
      if (allDatas[i].date.isAfter(
            now
                .subtract(
                  const Duration(days: 29),
                )
                .simplified,
          )) {
        tempList.add(allDatas[i].newWithIndex(i));
      }
    }
    return tempList;
    // return allDatas
    //     .where((element) => element.date.isAfter(
    //           now
    //               .subtract(
    //                 const Duration(days: 29),
    //               )
    //               .simplified,
    //         ))
    //     .toList();
  }

  @override
  List<TransactionModel> getSelectMonthReport({
    int? month,
  }) {
    List<TransactionModel> tempList = [];
    for (int i = 0; i < allDatas.length; i++) {
      if (allDatas[i].date.month == (month ?? selectedMonth.value) &&
          allDatas[i].date.year == now.year) {
        tempList.add(allDatas[i].newWithIndex(i));
      }
    }
    return tempList;
    // return allDatas
    //     .where((p0) =>
    //         p0.date.month == (month ?? selectedMonth.value) &&
    //         p0.date.year == now.year)
    //     .toList();
  }

  @override
  List<TransactionModel> getSelectRangeDayReport({
    DateTime? firstDate,
    DateTime? secondDate,
  }) {
    List<TransactionModel> tempList = [];
    for (int i = 0; i < allDatas.length; i++) {
      if (allDatas[i]
              .date
              .isAfter((firstDate ?? firstRangedDate.value).simplified) &&
          allDatas[i].date.isBefore(
                (secondDate ?? secondRangedDate.value)
                    .subtract(const Duration(days: -1))
                    .simplified,
              )) {
        tempList.add(allDatas[i].newWithIndex(i));
      }
    }
    return tempList;
    // return allDatas
    //     .where(
    //       (element) =>
    //           element.date
    //               .isAfter((firstDate ?? firstRangedDate.value).simplified) &&
    //           element.date.isBefore(
    //             (secondDate ?? secondRangedDate.value)
    //                 .subtract(const Duration(days: -1))
    //                 .simplified,
    //           ),
    //     )
    //     .toList();
  }

  @override
  List<TransactionModel> getSelectRangeMonthReport({
    int? firstMonth,
    int? secondMonth,
  }) {
    List<TransactionModel> tempList = [];
    for (int i = 0; i < allDatas.length; i++) {
      if (allDatas[i].date.month >= (firstMonth ?? firstRangedMonth.value) &&
          allDatas[i].date.month <= (secondMonth ?? secondRangedMonth.value)) {
        tempList.add(allDatas[i].newWithIndex(i));
      }
    }
    return tempList;
    // return allDatas
    //     .where(
    //       (element) =>
    //           element.date.month >= (firstMonth ?? firstRangedMonth.value) &&
    //           element.date.month <= (secondMonth ?? secondRangedMonth.value),
    //     )
    //     .toList();
  }

  @override
  List<TransactionModel> getThisMonthReport() {
    List<TransactionModel> tempList = [];
    for (int i = 0; i < allDatas.length; i++) {
      if (allDatas[i].date.isThisMonth()) {
        tempList.add(allDatas[i].newWithIndex(i));
      }
    }
    return tempList;
    // return allDatas
    //     .where(
    //       (p0) => p0.date.isThisMonth(),
    //     )
    //     .toList();
  }

  @override
  List<TransactionModel> getTodayReport() {
    List<TransactionModel> tempList = [];
    for (int i = 0; i < allDatas.length; i++) {
      if (allDatas[i].date.isToday()) {
        tempList.add(allDatas[i].newWithIndex(i));
      }
    }
    return tempList;
    // return allDatas
    //     .where(
    //       (p0) => p0.date.isToday(),
    //     )
    //     .toList();
  }

  @override
  List<TransactionModel> getYesterdayReport() {
    List<TransactionModel> tempList = [];
    for (int i = 0; i < allDatas.length; i++) {
      if (allDatas[i].date.day == now.subtract(const Duration(days: 1)).day) {
        tempList.add(allDatas[i].newWithIndex(i));
      }
    }
    return tempList;
    // return allDatas
    //     .where(
    //       (p0) => p0.date.day == now.subtract(const Duration(days: 1)).day,
    //     )
    //     .toList();
  }
}
