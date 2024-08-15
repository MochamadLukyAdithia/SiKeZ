import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/dasboard/screen/dashboard_page.dart';
import 'package:hmj_apps/presentation/navigation/controller/navigation_controller.dart';
import 'package:hmj_apps/presentation/profile/screen/profile_page.dart';
import 'package:hmj_apps/presentation/report/screen/report_screen.dart';

class NavigationPage extends GetView<NavigationController> {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -4),
            )
          ]),
          child: BottomNavigationBar(
            selectedFontSize: 14,
            unselectedFontSize: 12,
            selectedItemColor: AppColors.secondaryColor,
            unselectedItemColor: Colors.black,
            onTap: controller.changeNavigationIndex,
            currentIndex: controller.currentIndex,
            items: List.generate(3, (index) => _getBottomNavbarItem(index)),
          ),
        ),
        body: <Widget>[
          const DashboardPage(),
          const ReportScreen(),
          const ProfilePage()
        ][controller.currentIndex],
      ),
    );
  }

  BottomNavigationBarItem _getBottomNavbarItem(int index) {
    final pageItem = controller.pageList[index];
    final isSelecteed = index == controller.currentIndex;
    return BottomNavigationBarItem(
      label: pageItem.name,
      icon: SvgPicture.asset(
        width: isSelecteed ? 24 : 20,
        height: isSelecteed ? 24 : 20,
        fit: BoxFit.fitWidth,
        isSelecteed ? pageItem.iconPathOn : pageItem.iconPathOff,
      ),
    );
  }
}
