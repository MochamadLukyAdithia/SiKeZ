// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
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
        FilterMode.selectMonth,
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
  ModalModel getTodayReport() {
    late final LabaCompilationModel labaCompilationModel;
    if (currentFilter.value == FilterMode.today) {
      labaCompilationModel = reportLabaController.getLabaBeforeMonth(
        month: selectedDate.value.month,
      );
    } else {
      labaCompilationModel =
          reportLabaController.getLabaBeforeMonth(month: selectedMonth.value);
    }

    List<TransactionModel> addModalTransaction = [];
    List<TransactionModel> takeModalTransaction = [];
    List<TransactionModel> addModalTransactionOld = [];
    List<TransactionModel> takeModalTransactionOld = [];

    for (var data in allDatas) {
      if (data.transactionId == 6) {
        if (currentFilter.value == FilterMode.today) {
          if (data.date.month == selectedDate.value.month &&
              data.date.year == selectedDate.value.year) {
            addModalTransaction.add(data);
          } else if (data.date
              .isBefore(DateTime(now.year, selectedDate.value.month, 1))) {
            addModalTransactionOld.add(data);
          }
        } else {
          if (data.date.month == selectedMonth.value &&
              data.date.year == now.year) {
            addModalTransaction.add(data);
          } else if (data.date
              .isBefore(DateTime(now.year, selectedMonth.value, 1))) {
            addModalTransactionOld.add(data);
          }
        }
      } else if (data.transactionId == 7) {
        if (currentFilter.value == FilterMode.today) {
          if (data.date.month == selectedDate.value.month &&
              data.date.year == selectedDate.value.year) {
            takeModalTransaction.add(data);
          } else if (data.date
              .isBefore(DateTime(now.year, selectedDate.value.month, 1))) {
            takeModalTransactionOld.add(data);
          }
        } else {
          if (data.date.month == selectedMonth.value &&
              data.date.year == now.year) {
            takeModalTransaction.add(data);
          } else if (data.date
              .isBefore(DateTime(now.year, selectedMonth.value, 1))) {
            takeModalTransactionOld.add(data);
          }
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
          .getSelectMonthReport(
            month: currentFilter.value == FilterMode.today
                ? selectedDate.value.month
                : selectedMonth.value,
          )
          .cleanResult,
      addedModal: addModalTransaction,
      takedModal: takeModalTransaction,
    );
  }

  @override
  ModalModel getYesterdayReport() => throw UnimplementedError();
}
