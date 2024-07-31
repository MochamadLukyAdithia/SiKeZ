// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' as getx;
// import 'package:get/get_navigation/get_navigation.dart';

// import 'package:hmj_apps/core/network/token_service.dart';
// import 'package:hmj_apps/core/theme/theme_controller.dart';

// class TokenInterceptor extends Interceptor {
//   final TokenService _tokenService;
//   TokenInterceptor(this._tokenService);

//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     final token = await _tokenService.getToken();

//     // if (AuthController.find.isTokenSaved) {
//     //   options.headers['Authorization'] = 'Bearer $token';
//     // } else {
//     //   options.headers['Authorization'] = 'Bearer ${AuthController.find.token}';
//     // }
//     // options.headers['Accept'] = 'application/json';

//     log('Request Method: ${options.method}');
//     log('Request URL: ${options.uri}');
//     log('Request Headers: ${options.headers}');
//     if (options.data != null) {
//       log('Request Body: ${options.data}');
//     }
//     super.onRequest(options, handler);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     log("Response Status Code: ${response.statusCode}");
//     log("Response Data: ${response.data}");
//     super.onResponse(response, handler);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     if (err.response?.statusCode == 401) {
//       if (!getx.Get.isSnackbarOpen) {
//         getx.Get.rawSnackbar(
//           // backgroundColor: ThemeController.find.theme.danger.shade1,
//           message: "Anda belum terauntikasi, silahkan masuk untuk melanjutkan.",
//           borderRadius: 8,
//           snackPosition: SnackPosition.TOP,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           margin: const EdgeInsets.all(16),
//         );
//       }

//       // if (AuthController.find.authState.value != AuthState.loggedOut &&
//       //     getx.Get.currentRoute != AppRoute.loginPage) {
//       //   AuthController.find.logout();
//       // }
//     }
//     super.onError(err, handler);
//   }
// }
