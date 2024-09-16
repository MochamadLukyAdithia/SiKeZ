import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/date_extension.dart';
import 'package:hmj_apps/model/transaction_model.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_base_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_transaction_list_controller.dart';

class LabaCompilationModel {
  LabaModel pendapatanDariPenjualan;
  LabaModel bebanOperasional;
  LabaModel bebanLainya;

  int get cleanResult =>
      pendapatanDariPenjualan.totalAmount -
      bebanOperasional.totalAmount -
      bebanLainya.totalAmount;

  LabaCompilationModel({
    required this.pendapatanDariPenjualan,
    required this.bebanOperasional,
    required this.bebanLainya,
  });
}

class LabaModel {
  final String name;
  List<LabaItemModel> items;

  int get totalAmount =>
      items.fold(0, (previousValue, element) => previousValue + element.amount);

  LabaModel({
    required this.name,
    required this.items,
  });
}

class LabaItemModel {
  final String code;
  final String name;
  int amount;

  LabaItemModel({
    required this.code,
    required this.name,
    required this.amount,
  });
}

class ReportLabaController extends ReportBaseController<LabaCompilationModel> {
  final ReportTransactionListController transactionListController =
      Get.find<ReportTransactionListController>();

  @override
  List<FilterMode> get filters => [
        FilterMode.today,
        FilterMode.yesterday,
        FilterMode.last7Days,
        FilterMode.last30Days,
        FilterMode.thisMonth,
        FilterMode.lastMonth,
        FilterMode.selectRangeDate,
        FilterMode.selectMonth,
      ];

  @override
  LabaCompilationModel getLast7DaysReport() => getProcessedData(
        transactionListController.getLast7DaysReport(),
      );

  @override
  LabaCompilationModel getLastMonthReport() => getProcessedData(
        transactionListController.getLastMonthReport(),
      );

  @override
  LabaCompilationModel getLasy30DaysReport() => getProcessedData(
        transactionListController.getLasy30DaysReport(),
      );

  @override
  LabaCompilationModel getSelectMonthReport({int? month}) => getProcessedData(
        transactionListController.getSelectMonthReport(
            month: month ?? selectedMonth.value),
      );

  @override
  LabaCompilationModel getSelectRangeDayReport({
    DateTime? firstDate,
    DateTime? secondDate,
  }) =>
      getProcessedData(
        transactionListController.getSelectRangeDayReport(
          firstDate: firstRangedDate.value,
          secondDate: secondRangedDate.value,
        ),
      );
  @override
  LabaCompilationModel getSelectRangeMonthReport({
    int? firstMonth,
    int? secondMonth,
  }) {
    throw UnimplementedError();
  }

  @override
  LabaCompilationModel getThisMonthReport() => getProcessedData(
        transactionListController.getThisMonthReport(),
      );

  @override
  LabaCompilationModel getTodayReport() => getProcessedData(
        transactionListController.getTodayReport(),
      );

  LabaCompilationModel getLabaBeforeDay({required DateTime day}) {
    final rawData = allDatas
        .where(
          (element) => element.date.isBefore(day.simplified),
        )
        .toList();

    return getProcessedData(rawData);
  }

  LabaCompilationModel getLabaSpecificDay({required DateTime day}) {
    final rawData = allDatas
        .where(
          (element) => element.date.isSameDate(day),
        )
        .toList();

    return getProcessedData(rawData);
  }

  LabaCompilationModel getProcessedData(List<TransactionModel> list) {
    LabaModel pendapatanDariPenjualan =
        LabaModel(name: "Pendapatan dari Penjualan", items: []);
    LabaModel bebanOperasional =
        LabaModel(name: "Beban Operasional", items: []);
    LabaModel bebanLainya = LabaModel(name: "Beban Lainya", items: []);

    for (var data in list) {
      if (data.creditCode.startsWith("4")) {
        final index = pendapatanDariPenjualan.items
            .indexWhere((element) => element.code == data.creditCode);
        if (index < 0) {
          final model = LabaItemModel(
              code: data.creditCode,
              name: data.creditName,
              amount: data.nominal);
          pendapatanDariPenjualan.items.add(model);
        } else {
          pendapatanDariPenjualan.items[index].amount += data.nominal;
        }
      } else if (data.debitCode.startsWith("5")) {
        if (data.debitCode != '5-1700') {
          final index = bebanOperasional.items
              .indexWhere((element) => element.code == data.debitCode);
          if (index < 0) {
            final model = LabaItemModel(
              code: data.debitCode,
              name: data.debitName,
              amount: data.nominal,
            );
            bebanOperasional.items.add(model);
          } else {
            bebanOperasional.items[index].amount += data.nominal;
          }
        } else {
          final index = bebanLainya.items
              .indexWhere((element) => element.code == data.debitCode);
          if (index < 0) {
            final model = LabaItemModel(
              code: data.debitCode,
              name: data.debitName,
              amount: data.nominal,
            );
            bebanLainya.items.add(model);
          } else {
            bebanLainya.items[index].amount += data.nominal;
          }
        }
      }
    }

    return LabaCompilationModel(
      pendapatanDariPenjualan: pendapatanDariPenjualan,
      bebanOperasional: bebanOperasional,
      bebanLainya: bebanLainya,
    );
  }

  @override
  LabaCompilationModel getYesterdayReport() => getProcessedData(
        transactionListController.getYesterdayReport(),
      );
}
