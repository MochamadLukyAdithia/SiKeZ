import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hmj_apps/presentation/auth/controller/auth_controller.dart';

final getIt = GetIt.I;

void configureDependencies() {
  getIt.registerSingleton(AuthController());
  if (kIsWeb) {
    Get.put(getIt<AuthController>(), permanent: true);
  }
}
