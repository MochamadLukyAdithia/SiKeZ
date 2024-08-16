import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';

class BaseController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxBool _isError = false.obs;

  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  bool get isError => _isError.value;

  bool get isLoading => _isLoading.value;

  set setIsLoading(bool value) {
    _isLoading.value = value;
  }

  set setIsError(bool value) {
    _isError.value = value;
  }

  showErrorToast({required String? msg}) {
    Fluttertoast.showToast(
      msg: msg ?? "Terjadi kesalahan.",
      gravity: ToastGravity.CENTER,
      backgroundColor: AppColors.tertiaryColor,
    );
  }

  showSuccessSnackbar({required String message}) {
    if (isError) return;
    Get.closeCurrentSnackbar();
    Get.rawSnackbar(
      borderRadius: 8,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.all(16),
      backgroundColor: AppColors.secondaryColor,
      snackPosition: SnackPosition.TOP,
      messageText: Text(
        message,
        style: AppTextStyle.body3.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  showLoading() {
    Get.dialog(
      PopScope(
        canPop: false,
        child: Center(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(24),
              child: const CircularProgressIndicator()),
        ),
      ),
    );
  }

  showErrorSnackbar({String? errorMessage}) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
        borderRadius: 8,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.all(16),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        messageText: Text(
          errorMessage ?? "Terjadi kesalahan server. Silahkan coba kembali.",
          style: AppTextStyle.body3.copyWith(
            color: Colors.white,
          ),
        ),
      );
    }
    setIsLoading = false;
    if (isError) return;
    setIsError = true;
  }
}
