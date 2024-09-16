// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/date_extension.dart';
import 'package:hmj_apps/model/transaction_model.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_base_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_laba_controller.dart';

class ModalModel {
  int modalAwal;
  int cleanLaba;
  List<TransactionModel> addedModal;
  List<TransactionModel> takedModal;

  int get addedModalAmount => addedModal.fold(
      0, (previousValue, element) => previousValue + element.nominal);
  int get takedModalAmount => takedModal.fold(
      0, (previousValue, element) => previousValue + element.nominal);

  int get getModalAkhir =>
      modalAwal + cleanLaba + addedModalAmount - takedModalAmount;

  ModalModel({
    required this.modalAwal,
    required this.cleanLaba,
    required this.addedModal,
    required this.takedModal,
  });
}

class ReportModalController extends ReportBaseController<ModalModel> {
  final ReportLabaController reportLabaController =
      Get.find<ReportLabaController>();

  @override
  List<FilterMode> get filters => [
        FilterMode.today,
        FilterMode.selectDay,
      ];

  @override
  ModalModel getLast7DaysReport() => throw UnimplementedError();

  @override
  ModalModel getLastMonthReport() => throw UnimplementedError();

  @override
  ModalModel getLasy30DaysReport() => throw UnimplementedError();

  @override
  ModalModel getSelectMonthReport({int? month}) => getTodayReport();

  @override
  ModalModel getSelectRangeDayReport(
          {DateTime? firstDate, DateTime? secondDate}) =>
      throw UnimplementedError();

  @override
  ModalModel getSelectRangeMonthReport({int? firstMonth, int? secondMonth}) =>
      throw UnimplementedError();

  @override
  ModalModel getThisMonthReport() => throw UnimplementedError();

  @override
  ModalModel getTodayReport({DateTime? dateTime}) {
    late final DateTime selectedDateF;
    if (dateTime != null) {
      selectedDateF = dateTime;
    } else if (currentFilter.value == FilterMode.today) {
      selectedDateF = DateTime.now();
    } else {
      selectedDateF = selectedDate.value;
    }

    late final LabaCompilationModel labaCompilationModel =
        reportLabaController.getLabaBeforeDay(day: selectedDateF);

    List<TransactionModel> addModalTransaction = [];
    List<TransactionModel> takeModalTransaction = [];
    List<TransactionModel> addModalTransactionOld = [];
    List<TransactionModel> takeModalTransactionOld = [];

    for (var data in allDatas) {
      if (data.creditCode.startsWith("3")) {
        if (data.date.isSameDate(selectedDateF)) {
          addModalTransaction.add(data);
        } else if (data.date.isBefore(selectedDateF.simplified)) {
          addModalTransactionOld.add(data);
        }
      } else if (data.debitCode.startsWith("3")) {
        if (data.date.isSameDate(selectedDateF)) {
          takeModalTransaction.add(data);
        } else if (data.date.isBefore(selectedDateF.simplified)) {
          takeModalTransactionOld.add(data);
        }
      }
    }

    final int modalAwal = addModalTransactionOld.fold(
            0, (previousValue, element) => previousValue + element.nominal) -
        takeModalTransactionOld
            .fold(
                0, (previousValue, element) => previousValue + element.nominal)
            .toInt() +
        labaCompilationModel.cleanResult;

    return ModalModel(
      modalAwal: modalAwal,
      cleanLaba: reportLabaController
          .getLabaSpecificDay(day: selectedDateF)
          .cleanResult,
      addedModal: addModalTransaction,
      takedModal: takeModalTransaction,
    );
  }

  @override
  ModalModel getYesterdayReport() => throw UnimplementedError();
}
