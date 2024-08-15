import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/core/utils/images.dart';
// import 'package:hmj_apps/presentation/auth/controller/auth_controller.dart';

class DasboardHeader extends StatelessWidget {
  const DasboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // final AuthController authController = AuthController.find;
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
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Total aset anda:",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              "Rp20.000.000",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              height: 2,
              color: Colors.white,
            ),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Laba Rugi bulan ini:",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Rp52.000.000,00",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "20% lebih banyak dari bulan sebelumnya",
                      style: TextStyle(fontSize: 12, color: Colors.amber),
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset(Images.iconBullish)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
