import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/presentation/profile/model/user_model.dart';

class ProfileController extends BaseController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  CollectionReference userData = FirebaseFirestore.instance.collection('users');

  var userProfileData = Rxn<UserProfle>();

  @override
  void onInit() {
    super.onInit();
    getProfileData();
  }

  final userid = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  Future<void> getProfileData() async {
    log("get data from fetch data");
    try {
      var dataProfileFromServer = await readProfileData();

      if (dataProfileFromServer != null) {
        log("data not null");
        userProfileData.value = dataProfileFromServer;
      }
    } catch (e) {
      log("error when get data user: $e ");
    }
  }

  Future<UserProfle?> readProfileData() async {
    try {
      DocumentSnapshot profileData = await userData.doc(userid.id).get();
      if (profileData.exists) {
        return UserProfle.fromJson(profileData.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      log("Error When Read data user: $e");
      return null;
    }
  }

  Future<void> updateProfileData() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      try {
        String name = formKey.currentState!.value['nama'];
        String address = formKey.currentState!.value['alamat'];
        String phone = formKey.currentState!.value['nomor'];
        log(userid.id);
        await userData.doc(userid.id).update({
          'name': name,
          'address': address,
          'phoneNumber': phone,
        });
        showSuccessSnackbar(message: "Berhasil Mengubah Data Profile");
      } catch (e) {
        showErrorSnackbar(
            errorMessage: "Terjadi Kesalahan Ketika Mengubah Data");
      }
    }
  }
}
