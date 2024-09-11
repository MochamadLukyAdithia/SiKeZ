import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/core/extension/date_extension.dart';
import 'package:hmj_apps/model/transaction_model.dart';
import 'package:hmj_apps/presentation/dasboard/controller/dashboard_controller.dart';

enum FilterMode {
  today,
  yesterday,
  last7Days,
  last30Days,
  thisMonth,
  lastMonth,
  selectMonth,
  selectRangeDate,
  selectRangeMonth,
}

abstract class ReportBaseController<T> extends BaseController {
  final dashboardController = Get.find<DashboardController>();

  List<TransactionModel> get allDatas => dashboardController.transactionList;
  final now = DateTime.now();
  final Rx<FilterMode> currentFilter = FilterMode.today.obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxInt selectedMonth = DateTime.now().month.obs;

  final Rx<DateTime> firstRangedDate =
      DateTime.now().subtract(const Duration(days: 1)).obs;

  final Rx<DateTime> secondRangedDate = DateTime.now().obs;

  final RxInt firstRangedMonth = (max(1, DateTime.now().month - 1)).obs;
  final RxInt secondRangedMonth = (DateTime.now().month).obs;

  List<FilterMode> get filters;

  onChangeFilter(dynamic newFilter) {
    currentFilter.value = newFilter;
  }

  List<DropdownMenuItem> getDropdownMenuItems() {
    final dropDownMenuItems = List.generate(filters.length, (index) {
      late final String text;

      switch (filters[index]) {
        case FilterMode.today:
          text = "Hari ini, ${DateTime.now().toddMMMMyyyy()}";
        case FilterMode.yesterday:
          text = "Kemarin";
        case FilterMode.last7Days:
          text = "7 Hari Terakhir";
        case FilterMode.last30Days:
          text = "30 Hari Terakhir";
        case FilterMode.thisMonth:
          text = "Bulan ini";
        case FilterMode.lastMonth:
          text = "Bulan lalu";
        case FilterMode.selectMonth:
          text = "Pilih bulan";
        case FilterMode.selectRangeDate:
          text = "Pilih rentang tanggal";
        case FilterMode.selectRangeMonth:
          text = "Pilih rentang bulan";
      }
      return DropdownMenuItem(
        value: filters[index],
        child: Text(text),
      );
    });

    return dropDownMenuItems;
  }

  T getData() {
    switch (currentFilter.value) {
      case FilterMode.today:
        return getTodayReport();
      case FilterMode.yesterday:
        return getYesterdayReport();
      case FilterMode.last30Days:
        return getLasy30DaysReport();
      case FilterMode.last7Days:
        return getLast7DaysReport();
      case FilterMode.thisMonth:
        return getThisMonthReport();
      case FilterMode.selectMonth:
        return getSelectMonthReport();
      case FilterMode.selectRangeDate:
        return getSelectRangeDayReport();
      case FilterMode.selectRangeMonth:
        return getSelectRangeMonthReport();
      case FilterMode.lastMonth:
        return getLastMonthReport();
    }
  }

  T getTodayReport();

  T getYesterdayReport();

  T getLast7DaysReport();

  T getLasy30DaysReport();

  T getThisMonthReport();

  T getLastMonthReport();

  T getSelectMonthReport({
    int? month,
  });

  T getSelectRangeDayReport();

  T getSelectRangeMonthReport({
    int? month,
  });

  T getReport() {
    switch (currentFilter.value) {
      case FilterMode.today:
        return getTodayReport();
      case FilterMode.yesterday:
        return getYesterdayReport();
      case FilterMode.last7Days:
        return getLast7DaysReport();
      case FilterMode.last30Days:
        return getLasy30DaysReport();
      case FilterMode.thisMonth:
        return getThisMonthReport();
      case FilterMode.lastMonth:
        return getLastMonthReport();
      case FilterMode.selectMonth:
        return getSelectMonthReport();
      case FilterMode.selectRangeDate:
        return getSelectRangeDayReport();
      case FilterMode.selectRangeMonth:
        return getSelectRangeMonthReport();
    }
  }
}
