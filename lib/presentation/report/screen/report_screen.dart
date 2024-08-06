import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan"),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Get.toNamed(AppRoute.reportList);
              },
              title: Text("Neraca"),
              trailing: Icon(Icons.arrow_right_outlined),
            )
          ],
        ),
      ),
    );
  }
}
