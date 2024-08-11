import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/core/utils/images.dart';
import 'package:hmj_apps/presentation/auth/controller/auth_controller.dart';

class DasboardHeader extends StatelessWidget {
  const DasboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController.find;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xff19282F),
          Color(0xffB33030),
          Color.fromARGB(255, 210, 57, 57)
        ], stops: [
          0.01,
          0.5,
          0.9
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Obx(
        () => SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Halo, ${authController.currentUser?.name?.split(' ')[0] ?? ''}",
                style: AppTextStyle.body1.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                "Total Aset",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Rp52.000.000",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 3,
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Laba bulan ini:",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Rp20.000.000",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "20% dari bulan sebelumnya",
                        style: TextStyle(fontSize: 14, color: Colors.amber),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(Images.iconBullish)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
