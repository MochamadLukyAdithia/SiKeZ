import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/dasboard/screen/dashboard_screen.dart';
import 'package:hmj_apps/presentation/navigation/controller/navigation_controller.dart';
import 'package:hmj_apps/presentation/profile/screen/profile_page.dart';
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
            selectedIndex: controller.currentIndex,
            height: 60,
            destinations: const [
              NavigationDestination(
                  selectedIcon: Icon(Icons.home),
                  icon: Icon(Icons.home_outlined),
                  label: "dashboard"),
              NavigationDestination(
                  selectedIcon: Icon(Icons.document_scanner),
                  icon: Icon(Icons.document_scanner_outlined),
                  label: "report"),
              NavigationDestination(
                  selectedIcon: Icon(Icons.person_2_rounded),
                  icon: Icon(Icons.person_2_outlined),
                  label: "profile")
            ]),
        body: <Widget>[
          const DashboardSceen(),
          const ReportScreen(),
          const ProfilePage()
        ][controller.currentIndex],
      ),
    );
  }
}
