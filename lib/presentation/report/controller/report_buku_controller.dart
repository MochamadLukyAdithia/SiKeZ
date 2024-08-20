import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';

class BukuBesarController extends BaseController {
  @override
  void onInit() {
    getTransactionData();
    super.onInit();
  }

  getTransactionData() async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

    final transactionsRef =  FirebaseFirestore.instance.collection('transactions').doc(uid).get();
   

  }
}
