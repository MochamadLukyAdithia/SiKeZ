import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/presentation/profile/model/user_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends BaseController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  CollectionReference userData = FirebaseFirestore.instance.collection('users');
  final ImagePicker picker = ImagePicker();
  var selectedImage = Rxn<File>();
  // var storage = Firebases.instance;

  var userProfileData = Rxn<UserProfle>();

  @override
  void onInit() {
    super.onInit();
    selectedImage = Rxn<File>();
    getProfileData();
  }

  final userid = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  Future<void> getProfileData() async {
    try {
      var dataProfileFromServer = await readProfileData();

      if (dataProfileFromServer != null) {
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

  Future<void> uploadUserImage(String imagePath) async {
    String imageName = imagePath.substring(
        imagePath.lastIndexOf("/") + 1, imagePath.lastIndexOf("."));

    String path = imagePath.substring(
        imagePath.indexOf("/") + 1, imagePath.lastIndexOf("/"));

    final Directory systemTempDir = Directory.systemTemp;
    final byteData = await rootBundle.load(imagePath);
    final file = File('${systemTempDir.path}/$imageName.jpg');

    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    //       Tasks taskSnapshot = await storage.ref('$path/$imageName').putFile(file);
    // final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    // await FirebaseFirestore.instance.collection(path).add({"url": downloadUrl, "name": imageName});
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

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }
}
