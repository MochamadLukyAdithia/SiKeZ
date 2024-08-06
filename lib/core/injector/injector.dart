import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hmj_apps/presentation/auth/controller/auth_controller.dart';

import 'package:image_picker/image_picker.dart';

final getIt = GetIt.I;

void configureDependencies() {
  getIt.registerSingleton(AuthController());
  getIt.registerSingleton(const FlutterSecureStorage());
  getIt.registerSingleton(ImagePicker());
}
