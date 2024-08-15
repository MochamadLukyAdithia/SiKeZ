import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/model/account_model.dart';
import 'package:hmj_apps/model/transaction_type_model.dart';
import 'package:image_picker/image_picker.dart';

class AddTransactionController extends BaseController {
  RxList<TransactionType> transactionTypeList = <TransactionType>[].obs;
  final Rxn<TransactionType> _selectedTransactionType = Rxn();

  TransactionType? get selectedTransactionType =>
      _selectedTransactionType.value;

  set setSelectedTransactionType(TransactionType transactionType) {
    _selectedTransactionType.value = transactionType;
  }

  RxList<Accounts> accountList = <Accounts>[].obs;

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
  void onInit() {
    getTransactionTypes();
    getAccounts();
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
}
