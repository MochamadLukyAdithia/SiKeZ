import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/presentation/dasboard/component/dasboard_body.dart';
import 'package:hmj_apps/presentation/dasboard/component/dasboard_header.dart';
import 'package:hmj_apps/presentation/dasboard/component/dashboard_center.dart';
import 'package:hmj_apps/presentation/dasboard/controller/dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: Column(
          children: [
            DasboardHeader(),
            DashboardCenter(),
            DashboardBody(),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
                colors: [Color(0xffA1B57D), Color(0xff464F37)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () async {
            Get.toNamed(AppRoute.addTransaction);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
