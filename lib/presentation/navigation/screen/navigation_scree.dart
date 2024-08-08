import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/dasboard/screen/dashboard_screen.dart';
import 'package:hmj_apps/presentation/navigation/controller/navigation_controller.dart';
import 'package:hmj_apps/presentation/profile/screen/profile_screen.dart';
import 'package:hmj_apps/presentation/report/screen/report_screen.dart';

class NavigationScreen extends GetView<NavigationController> {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              controller.changeNavigationIndex(index);
            },
            indicatorColor: AppColors.primaryColor,
            selectedIndex: controller.currentIndex.value,
            height: 60,
            destinations: [
              NavigationDestination(
                  selectedIcon: const Icon(Icons.home),
                  icon: const Icon(Icons.home_outlined),
                  label: "dashboard"),
              NavigationDestination(
                  selectedIcon: const Icon(Icons.document_scanner),
                  icon: const Icon(Icons.document_scanner_outlined),
                  label: "report"),
              NavigationDestination(
                  selectedIcon: const Icon(Icons.person_2_rounded),
                  icon: const Icon(Icons.person_2_outlined),
                  label: "profile")
            ]),
        body: <Widget>[
          const DashboardSceen(),
          const ReportScreen(),
          const ProfileScreen()
        ][controller.currentIndex.value],
      ),
    );
  }
}
