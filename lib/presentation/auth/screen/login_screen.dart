import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:get/get.dart";
import "package:hmj_apps/core/helper/form_validation.dart";
import "package:hmj_apps/core/theme/app_colors.dart";
import "package:hmj_apps/presentation/auth/controller/auth_controller.dart";
import "package:hmj_apps/presentation/shared/custom_button.dart";
import 'package:hmj_apps/presentation/shared/custom_text_field.dart';
import "package:hmj_apps/resources/assets.gen.dart";

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: Get.height * 0.3,
                child: Image.asset(
                  "assets/images/coffee_background.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: FormBuilder(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.images.logo.image(
                          width: Get.width * 0.3,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "SIKEPI",
                          style: Get.textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.tertiaryColor,
                          ),
                        ),
                        Text(
                          "\"Sistem Keuangan Kopi\"",
                          style: Get.textTheme.titleSmall?.copyWith(
                            // fontWeight: FontWeight.w700,
                            color: AppColors.tertiaryColor,
                          ),
                        ),
                        const SizedBox(height: 62),
                        const CustomTextWithTitle(
                          name: "email",
                          validator: FormValidation.isEmail,
                          label: "Email",
                          hintText: "Masukkan email anda...",
                        ),
                        const SizedBox(height: 16),
                        const CustomTextWithTitle(
                          name: "password",
                          validator: FormValidation.isNotNullAndRequired,
                          label: "Password",
                          hintText: "Masukkan kata sandi anda...",
                        ),
                        const SizedBox(height: 48),
                        SiKePeLinearButton(
                          title: "Masuk",
                          onPressed: controller.loginWithEmailAndPassword,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                height: 1.5,
                                thickness: 1.5,
                                color: AppColors.quaternaryColor,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "atau",
                                style: Get.textTheme.bodySmall?.copyWith(
                                  color: AppColors.quaternaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                height: 1.5,
                                thickness: 1.5,
                                color: AppColors.quaternaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SiKePeLinearButton(
                          title: "Masuk dengan Google",
                          onPressed: controller.loginWithGoogle,
                          customWidget: Assets.icons.google.svg(width: 24),
                          color: Colors.black,
                          linearGradient: const LinearGradient(
                            colors: [
                              Colors.white,
                              AppColors.lightGrey,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
