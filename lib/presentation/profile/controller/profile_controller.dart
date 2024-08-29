import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/presentation/auth/controller/auth_controller.dart';
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
    showLoading();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (formKey.currentState?.saveAndValidate() ?? false) {
      try {
        String name = formKey.currentState!.value['nama'];
        String address = formKey.currentState!.value['alamat'];
        String phone = formKey.currentState!.value['nomor'];
        String downloadUrl = "";
        if (selectedImage.value != null) {
          downloadUrl = await uploadUserImage(selectedImage.value!);
          await userData.doc(userId).update({'imageUrl': downloadUrl});
        }
        await userData.doc(userId).update({
          'name': name,
          'address': address,
          'phoneNumber': phone,
        });
        Get.back();
        Get.back();
        showSuccessSnackbar(message: "Berhasil mengubah data profile");
        AuthController.find.getUser();
      } on FirebaseException catch (e) {
        Get.back();
        showErrorSnackbar(
            errorMessage:
                "Terjadi kesalahan ketika mengubah data. ${e.message}");
      } catch (e) {
        Get.back();
        showErrorSnackbar(
            errorMessage: "Terjadi kesalahan ketika mengubah data.");
      }
    }
  }

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }
}
