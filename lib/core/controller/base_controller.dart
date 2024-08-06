import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';

class BaseController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxBool _isError = false.obs;

  bool get isError => _isError.value;

  bool get isLoading => _isLoading.value;

  set setIsLoading(bool value) {
    _isLoading.value = value;
  }

  set setIsError(bool value) {
    _isError.value = value;
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

  showErrorSnackbar({required String errorMessage}) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
        borderRadius: 8,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.all(16),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        messageText: Text(
          errorMessage,
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
