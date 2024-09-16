import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
// import 'package:hmj_apps/core/extension/date_extension.dart';
import 'package:hmj_apps/model/account_model.dart';
import 'package:hmj_apps/model/transaction_type_model.dart';
import 'package:hmj_apps/presentation/dasboard/controller/dashboard_controller.dart';
// import 'package:hmj_apps/presentation/report/controller/report_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddTransactionController extends BaseController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  RxList<TransactionType> transactionTypeList = <TransactionType>[].obs;
  final DashboardController dashboardController =
      Get.find<DashboardController>();

  final Rxn<TransactionType> _selectedTransactionType = Rxn();

  TransactionType? get selectedTransactionType =>
      _selectedTransactionType.value;

  set setSelectedTransactionType(TransactionType transactionType) {
    _selectedFirstAccounts.value = null;
    _selectedSecondAccounts.value = null;
    if (transactionType.id == 1) {
      _selectedFirstAccounts.value =
          accountList.firstWhereOrNull((element) => element.code == "1-1100");
      _selectedSecondAccounts.value =
          accountList.firstWhereOrNull((element) => element.code == "4-1100");
    } else if (transactionType.id == 2) {
      _selectedSecondAccounts.value =
          accountList.firstWhereOrNull((element) => element.code == "1-1100");
    } else if (transactionType.id == 3) {
      _selectedFirstAccounts.value =
          accountList.firstWhereOrNull((element) => element.code == "1-1300");
      _selectedSecondAccounts.value =
          accountList.firstWhereOrNull((element) => element.code == "4-1100");
    } else if (transactionType.id == 4) {
      _selectedSecondAccounts.value =
          accountList.firstWhereOrNull((element) => element.code == "2-1100");
    } else if (transactionType.id == 5) {
      _selectedSecondAccounts.value =
          accountList.firstWhereOrNull((element) => element.code == "1-1100");
    } else if (transactionType.id == 6) {
      _selectedSecondAccounts.value =
          accountList.firstWhereOrNull((element) => element.code == "3-1100");
    } else if (transactionType.id == 7) {
      _selectedFirstAccounts.value =
          accountList.firstWhereOrNull((element) => element.code == "3-1200");
    } else if (transactionType.id == 8) {
      _selectedFirstAccounts.value =
          accountList.firstWhereOrNull((element) => element.code == "1-1100");
      _selectedSecondAccounts.value =
          accountList.firstWhereOrNull((element) => element.code == "2-2100");
    }

    _selectedTransactionType.value = transactionType;
  }

  RxList<Accounts> accountList = <Accounts>[].obs;

  List<Accounts> getProperDebits() {
    if (selectedTransactionType == null) return [];
    if (selectedTransactionType!.id == 1) {
      return accountList.where((p0) => p0.code == "1-1100").toList();
    } else if (selectedTransactionType!.id == 2) {
      return accountList
          .where((p0) => RegExp(r'^[125]').hasMatch(p0.code!))
          .toList();
    } else if (selectedTransactionType!.id == 3) {
      return accountList.where((p0) => p0.code == "1-1300").toList();
    } else if (selectedTransactionType!.id == 4) {
      return accountList
          .where((p0) => RegExp(r'^[15]').hasMatch(p0.code!))
          .toList();
    } else if (selectedTransactionType!.id == 5) {
      return accountList
          .where((p0) => RegExp(r'^[15]').hasMatch(p0.code!))
          .toList();
    } else if (selectedTransactionType!.id == 6) {
      return accountList
          .where((p0) => RegExp(r'^[1]').hasMatch(p0.code!))
          .toList();
    } else if (selectedTransactionType!.id == 7) {
      return accountList.where((p0) => p0.code == "1-1100").toList();
    } else if (selectedTransactionType!.id == 8) {
      return accountList.where((p0) => p0.code == "3-1200").toList();
    } else {
      return accountList;
    }
  }

  List<Accounts> getProperCredits() {
    if (selectedTransactionType == null) return [];
    if (selectedTransactionType!.id == 1) {
      return accountList.where((p0) => p0.code == "4-1100").toList();
    } else if (selectedTransactionType!.id == 2) {
      return accountList.where((p0) => p0.code == "1-1100").toList();
    } else if (selectedTransactionType!.id == 3) {
      return accountList.where((p0) => p0.code == "4-1100").toList();
    } else if (selectedTransactionType!.id == 4) {
      return accountList.where((p0) => p0.code == "2-1100").toList();
    } else if (selectedTransactionType!.id == 5) {
      return accountList.where((p0) => p0.code == "1-1100").toList();
    } else if (selectedTransactionType!.id == 6) {
      return accountList.where((p0) => p0.code == "3-1100").toList();
    } else if (selectedTransactionType!.id == 7) {
      return accountList.where((p0) => p0.code!.startsWith("1")).toList();
    } else if (selectedTransactionType!.id == 8) {
      return accountList.where((p0) => p0.code == "2-2100").toList();
    } else {
      return accountList;
    }
  }

  final Rxn<Accounts> _selectedFirstAccounts = Rxn();

  Accounts? get selectedFirstAccounts => _selectedFirstAccounts.value;

  set setSelectedFirstAccounts(Accounts newAccounts) {
    _selectedFirstAccounts.value = newAccounts;
  }

  final Rxn<Accounts> _selectedSecondAccounts = Rxn();

  Accounts? get selectedSecondAccounts => _selectedSecondAccounts.value;

  set setSelectedSecondAccounts(Accounts newAccounts) {
    _selectedSecondAccounts.value = newAccounts;
  }

  final Rxn<File> _selectedFile = Rxn();

  File? get selectedFile => _selectedFile.value;

  set setSelectedFile(XFile file) {
    _selectedFile.value = File(file.path);
  }

  final Rx<DateTime> _selectedDate = DateTime.now().obs;

  DateTime get selectedDate => _selectedDate.value;

  set setSelectedDate(DateTime date) {
    _selectedDate.value = date;
  }

  final Rx<TimeOfDay> _selectedTime = TimeOfDay.now().obs;

  TimeOfDay get selectedTime => _selectedTime.value;

  set setSelectedTimeOfDay(TimeOfDay timeOfDay) {
    _selectedTime.value = timeOfDay;
  }

  @override
  void onInit() async {
    await getAccounts();
    await getTransactionTypes();
    super.onInit();
  }

  getTransactionTypes() async {
    try {
      final snapshot = await firestore.collection('transaction_type').get();

      List<TransactionType> tempTransactionTypeList = [];
      for (var transaction in snapshot.docs) {
        tempTransactionTypeList
            .add(TransactionType.fromJson(transaction.data()));
      }
      transactionTypeList.value = tempTransactionTypeList;
      if (tempTransactionTypeList.isNotEmpty) {
        setSelectedTransactionType = tempTransactionTypeList[0];
      }
    } on FirebaseException catch (firebaseError) {
      showErrorSnackbar(errorMessage: firebaseError.message);
    } catch (e) {
      showErrorSnackbar(errorMessage: e.toString());
    }
  }

  getAccounts() async {
    try {
      final snapshot = await firestore.collection('accounts').get();

      List<Accounts> tempAccountsList = [];
      for (var account in snapshot.docs) {
        tempAccountsList.add(Accounts.fromJson(account.data()));
      }

      accountList.value = tempAccountsList;
    } on FirebaseException catch (firebaseError) {
      showErrorSnackbar(errorMessage: firebaseError.message);
    } catch (e) {
      showErrorSnackbar(errorMessage: e.toString());
    }
  }

  save() async {
    if (selectedTransactionType == null) {
      showErrorToast(msg: "Jenis Transaksi tidak boleh kosong!");
      return;
    }
    if (selectedFirstAccounts == null) {
      showErrorToast(msg: "Jenis Transaksi tidak boleh kosong!");
      return;
    }
    if (selectedSecondAccounts == null) {
      showErrorToast(msg: "Kredit tidak boleh kosong!");
      return;
    }

    if (formKey.currentState?.saveAndValidate() ?? false) {
      try {
        showLoading();
        final int nominal = int.parse(formKey.currentState?.value['nominal']);
        final String notes = formKey.currentState?.value['notes'];
        final dateTime = selectedDate.copyWith(
            hour: selectedTime.hour, minute: selectedTime.minute);
        String imageUrl = "";
        if (selectedFile != null) {
          final ref = FirebaseStorage.instance.ref(
              "${FirebaseAuth.instance.currentUser?.uid}/transaction-${dateTime.toIso8601String()}.jpg");

          await ref.putFile(selectedFile!);
          imageUrl = await ref.getDownloadURL();
        }

        final data = {
          "id": const Uuid().v4(),
          "nominal": nominal,
          "notes": notes,
          "date": dateTime.millisecondsSinceEpoch,
          "imageUrl": imageUrl,
          "transaction_name": selectedTransactionType!.name,
          "transaction_id": selectedTransactionType!.id,
          "debit_code": selectedFirstAccounts!.code,
          "debit_name": selectedFirstAccounts!.name,
          "credit_code": selectedSecondAccounts!.code,
          "credit_name": selectedSecondAccounts!.name,
        };
        final ref = firestore
            .collection('transactions')
            .doc(FirebaseAuth.instance.currentUser?.uid ?? '');
        if (dashboardController.transactionList.isEmpty) {
          await ref.set({
            "data": [data],
          });
        } else {
          await ref.update({
            "data": FieldValue.arrayUnion([data]),
          });
        }

        // if (dashboardController.selectedDate.toddMMyyyy() ==
        // selectedDate.toddMMyyyy()) {
        dashboardController.getTransactions(fromInit: true);
        //   Get.find<ReportController>().getTransactions();
        // }
        Get.until((route) => route.isFirst);

        showSuccessSnackbar(message: "Transaksi berhasil dibuat!");
      } on FirebaseException catch (e) {
        Get.back();
        showErrorSnackbar(errorMessage: e.message ?? "Terjadi kesalahan.");
      } catch (e) {
        Get.back();
        showErrorSnackbar(errorMessage: e.toString());
      }
    }
  }
}
