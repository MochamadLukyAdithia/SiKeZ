import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:get/get.dart";
import "package:hmj_apps/core/helper/form_validation.dart";
import "package:hmj_apps/core/theme/theme_controller.dart";
import "package:hmj_apps/presentation/auth/controller/auth_controller.dart";
import 'package:hmj_apps/presentation/shared/custom_text_field.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.find;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(10),
          child: FormBuilder(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextWithTitle(
                  name: "email",
                  validator: FormValidation.isEmail,
                  hintText: "Masukkan Email",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextWithTitle(
                  name: "password",
                  validator: FormValidation.isValidPassword,
                  hintText: "Masukkan Password",
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                    
                        if (controller.formKey.currentState != null &&
                                controller.formKey.currentState!
                                    .saveAndValidate()) {
                                controller.login();
                            }
                    },
                    child: const Text("Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
