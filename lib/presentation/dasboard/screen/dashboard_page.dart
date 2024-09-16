// import 'package:dartz/dartz_unsafe.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/presentation/dasboard/component/dashboard_body.dart';
import 'package:hmj_apps/presentation/dasboard/component/dasboard_header.dart';
import 'package:hmj_apps/presentation/dasboard/component/dashboard_center.dart';
import 'package:hmj_apps/presentation/dasboard/controller/dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff19282F),
      body: RefreshIndicator.adaptive(
        onRefresh: () => controller.getTransactions(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DasboardHeader(),
                    DashboardCenter(),
                    DashboardBody(),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                color: Colors.white,
              ),
            ),
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
            // final l = (controller.transactionList
            //         .where((p0) => p0.debitCode.startsWith(p0.creditCode[0])))
            //     .toList();

            // l.forEach((element) {
            //   print(element.transactionName);
            // print(element.debitName);
            // print(element.creditName);
            // });
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
