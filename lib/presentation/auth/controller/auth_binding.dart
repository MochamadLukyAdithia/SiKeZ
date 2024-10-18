import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/injector/injector.dart';
import 'package:hmj_apps/presentation/auth/controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    if (!kIsWeb) {
      Get.put(getIt<AuthController>(), permanent: true);
    }
  }
}
