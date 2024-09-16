import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/date_extension.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_base_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_laba_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_modal_controller.dart';

class NeracaModel {
  final List<HartaTransactionModel> hartaLancarList;
  final int labaRugi;
  final List<HartaTransactionModel> hutangList;
  final List<HartaTransactionModel> modalList;

  const NeracaModel({
    required this.hartaLancarList,
    required this.hutangList,
    required this.labaRugi,
    required this.modalList,
  });

  int get hartaLancarTotal => hartaLancarList.fold(
      0, (previousValue, element) => previousValue + element.nominal);

  int get hutangTotal => hutangList.fold(
      0, (previousValue, element) => previousValue + element.nominal);

  int get modalTotal =>
      modalList.fold(
          0, (previousValue, element) => previousValue + element.nominal) +
      labaRugi;
}

class HartaTransactionModel {
  final String code;
  final String name;
  int nominal;

  HartaTransactionModel({
    required this.code,
    required this.name,
    required this.nominal,
  });
}

class ReportNeracaController extends ReportBaseController<NeracaModel> {
  final ReportLabaController reportLabaController = Get.find();
  final ReportModalController reportModalController = Get.find();

  @override
  List<FilterMode> get filters => [
        FilterMode.today,
        FilterMode.selectDay,
      ];

  @override
  NeracaModel getLast7DaysReport() {
    throw UnimplementedError();
  }

  @override
  NeracaModel getLastMonthReport() {
    throw UnimplementedError();
  }

  @override
  NeracaModel getLasy30DaysReport() {
    throw UnimplementedError();
  }

  @override
  NeracaModel getSelectMonthReport({int? month}) {
    throw UnimplementedError();
  }

  @override
  NeracaModel getSelectRangeDayReport(
      {DateTime? firstDate, DateTime? secondDate}) {
    throw UnimplementedError();
  }

  @override
  NeracaModel getSelectRangeMonthReport({int? firstMonth, int? secondMonth}) {
    throw UnimplementedError();
  }

  @override
  NeracaModel getThisMonthReport() {
    throw UnimplementedError();
  }

  int getAssetTotal() {
    List<HartaTransactionModel> hartaLancarList = [];
    for (var data in allDatas) {
      if (data.creditCode.startsWith("1")) {
        final idx = hartaLancarList.indexWhere(
          (element) => element.code == data.creditCode,
        );
        if (idx >= 0) {
          hartaLancarList[idx].nominal -= data.nominal;
        } else {
          hartaLancarList.add(
            HartaTransactionModel(
              code: data.creditCode,
              name: data.creditName,
              nominal: -(data.nominal),
            ),
          );
        }
      }
      if (data.debitCode.startsWith("1")) {
        final idx = hartaLancarList.indexWhere(
          (element) => element.code == data.debitCode,
        );
        if (idx >= 0) {
          hartaLancarList[idx].nominal += data.nominal;
        } else {
          hartaLancarList.add(
            HartaTransactionModel(
              code: data.debitCode,
              name: data.debitName,
              nominal: data.nominal,
            ),
          );
        }
      }
    }

    return hartaLancarList.fold(
        0, (previousValue, element) => previousValue + element.nominal);
  }

  @override
  NeracaModel getTodayReport() {
    final selectedDateF = currentFilter.value == FilterMode.today
        ? DateTime.now()
        : selectedDate.value;

    List<HartaTransactionModel> hartaLancarList = [];
    final datas = allDatas.where((element) => element.date
        .isBefore(selectedDateF.subtract(const Duration(days: -1)).simplified));
    for (var data in datas) {
      if (data.creditCode.startsWith("1")) {
        final idx = hartaLancarList.indexWhere(
          (element) => element.code == data.creditCode,
        );
        if (idx >= 0) {
          hartaLancarList[idx].nominal -= data.nominal;
        } else {
          hartaLancarList.add(
            HartaTransactionModel(
              code: data.creditCode,
              name: data.creditName,
              nominal: -(data.nominal),
            ),
          );
        }
      }
      if (data.debitCode.startsWith("1")) {
        final idx = hartaLancarList.indexWhere(
          (element) => element.code == data.debitCode,
        );
        if (idx >= 0) {
          hartaLancarList[idx].nominal += data.nominal;
        } else {
          hartaLancarList.add(
            HartaTransactionModel(
              code: data.debitCode,
              name: data.debitName,
              nominal: data.nominal,
            ),
          );
        }
      }
    }

    List<HartaTransactionModel> hutangList = [];
    for (var data in datas) {
      if (data.creditCode.startsWith("2")) {
        final idx = hutangList.indexWhere(
          (element) => element.code == data.creditCode,
        );
        if (idx >= 0) {
          hutangList[idx].nominal += data.nominal;
        } else {
          hutangList.add(
            HartaTransactionModel(
              code: data.creditCode,
              name: data.creditName,
              nominal: data.nominal,
            ),
          );
        }
      }
      if (data.debitCode.startsWith("2")) {
        final idx = hutangList.indexWhere(
          (element) => element.code == data.debitCode,
        );
        if (idx >= 0) {
          hutangList[idx].nominal -= data.nominal;
        } else {
          hutangList.add(
            HartaTransactionModel(
              code: data.debitCode,
              name: data.debitName,
              nominal: -(data.nominal),
            ),
          );
        }
      }
    }

    List<HartaTransactionModel> modalList = [];

    for (var data in datas) {
      if (data.creditCode.startsWith("3")) {
        final idx = modalList.indexWhere(
          (element) => element.code == data.creditCode,
        );
        if (idx >= 0) {
          modalList[idx].nominal += data.nominal;
        } else {
          modalList.add(
            HartaTransactionModel(
              code: data.creditCode,
              name: data.creditName,
              nominal: data.nominal,
            ),
          );
        }
      }
      if (data.debitCode.startsWith("3")) {
        final idx = modalList.indexWhere(
          (element) => element.code == data.debitCode,
        );
        if (idx >= 0) {
          modalList[idx].nominal -= data.nominal;
        } else {
          modalList.add(
            HartaTransactionModel(
              code: data.debitCode,
              name: data.debitName,
              nominal: -(data.nominal),
            ),
          );
        }
      }
    }

    return NeracaModel(
      hartaLancarList: hartaLancarList,
      hutangList: hutangList,
      labaRugi: reportLabaController
          .getLabaBeforeDay(
            day: selectedDateF.subtract(const Duration(days: -1)),
          )
          .cleanResult,
      modalList: modalList,
    );
  }

  @override
  NeracaModel getYesterdayReport() {
    throw UnimplementedError();
  }
}
