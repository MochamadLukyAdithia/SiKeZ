import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/data/repository/auth_repository.dart';

class AuthController extends BaseController {
  // final AuthRepository authRepository;
  // final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  // AuthController(this.authRepository);

  // login() async {
  //   String email = formKey.currentState!.value['email'];
  //   String password = formKey.currentState!.value['password'];

  //   final result = await authRepository.login(email,password);

  //   result.fold(
  //     (l) => showErrorPopup(errorMessage: l),
  //     (r) async {
  //       showSuccessSnackbar(message: "Selamat Datang!");
  //       log(r.message);
  //     },
  //   );
  //   setIsLoading = false;
  // }
}
