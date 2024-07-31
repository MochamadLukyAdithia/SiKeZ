import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hmj_apps/data/repository/auth_repository.dart';
import 'package:hmj_apps/presentation/auth/controller/auth_controller.dart';

import 'package:image_picker/image_picker.dart';

final getIt = GetIt.I;

void configureDependencies() {
  getIt.registerSingleton(const FlutterSecureStorage());
  // getIt.registerSingleton(TokenService(getIt<FlutterSecureStorage>()));
  // getIt.registerSingleton(TokenInterceptor(getIt<TokenService>()));
  // getIt.registerSingleton(Dio()
  //   ..options = BaseOptions(
  //     baseUrl: AppEndpoints.baseUrl,
  //     connectTimeout: const Duration(seconds: 30),
  //     sendTimeout: const Duration(seconds: 30),
  //     receiveTimeout: const Duration(seconds: 30),
  //   )
  //   ..interceptors.add(getIt<TokenInterceptor>()));

  // getIt.registerSingleton(Connectivity());
  // getIt.registerSingleton(ConnectionChecker(getIt<Connectivity>()));

  getIt.registerSingleton(AuthRepository(
    firestore: FirebaseFirestore.instance,
  ));

  getIt.registerSingleton(ImagePicker());
  getIt.registerFactory(() => AuthController(getIt<AuthRepository>()));
}
