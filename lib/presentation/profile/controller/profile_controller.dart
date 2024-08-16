import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
  var storage = FirebaseStorage.instance;

  var userProfileData = Rxn<UserProfle>();

  @override
  var isLoading = false;

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

  Future<String> uploadUserImage(File imagePath) async {
    String imageName = imagePath.path.substring(
        imagePath.path.lastIndexOf("/") + 1, imagePath.path.lastIndexOf("."));
    log(imageName);

    String path = imagePath.path.substring(
        imagePath.path.indexOf("/") + 1, imagePath.path.lastIndexOf("/"));
    log(path);

    var storageRef =
        FirebaseStorage.instance.ref().child('driver_images/$imageName.jpg');
    var uploadTask = storageRef.putFile(imagePath);
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();

    return downloadUrl.toString();
  }

  Future<void> updateProfileData() async {
    isLoading = true;
    if (formKey.currentState?.saveAndValidate() ?? false) {
      try {
        String name = formKey.currentState!.value['nama'];
        String address = formKey.currentState!.value['alamat'];
        String phone = formKey.currentState!.value['nomor'];
        String downloadUrl = "";
        log(userid.id);
        if (selectedImage.value != null) {
          downloadUrl = await uploadUserImage(selectedImage.value!);
          await userData.doc(userid.id).update({'imageUrl': downloadUrl});
        }
        await userData.doc(userid.id).update({
          'name': name,
          'address': address,
          'phoneNumber': phone,
        });

        showSuccessSnackbar(message: "Berhasil Mengubah Data Profile");
        isLoading = false;
      } catch (e) {
        isLoading = false;
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
