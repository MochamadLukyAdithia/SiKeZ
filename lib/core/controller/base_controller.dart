import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/core/theme/theme_controller.dart';


class BaseController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxBool _isError = false.obs;

  final themeController = ThemeController.find;

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
      backgroundColor: themeController.theme.primaryColor,
      snackPosition: SnackPosition.TOP,
      messageText: Text(
        message,
        style: AppTextStyle.body3.copyWith(
          color: themeController.darkAppTheme.primaryTextColor,
        ),
      ),
    );
  }

  showErrorPopup({required String errorMessage}) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
        borderRadius: 8,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.all(16),
        backgroundColor: themeController.theme.danger.shade1,
        snackPosition: SnackPosition.TOP,
        messageText: Text(
          errorMessage,
          style: AppTextStyle.body3.copyWith(
            color: themeController.darkAppTheme.primaryTextColor,
          ),
        ),
      );
    }
    setIsLoading = false;
    if (isError) return;
    setIsError = true;
  }
}
