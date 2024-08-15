// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:hmj_apps/resources/assets.gen.dart';

class PageItem {
  final String iconPathOff;
  final String iconPathOn;
  final String name;
  PageItem({
    required this.iconPathOff,
    required this.iconPathOn,
    required this.name,
  });
}

class NavigationController extends GetxController {
  final pageList = [
    PageItem(
      iconPathOn: Assets.icons.homeIconOn.path,
      iconPathOff: Assets.icons.homeIconOff.path,
      name: "Beranda",
    ),
    PageItem(
      iconPathOn: Assets.icons.reportIconOn.path,
      iconPathOff: Assets.icons.reportIconOff.path,
      name: "Laporan",
    ),
    PageItem(
      iconPathOn: Assets.icons.profileIconOn.path,
      iconPathOff: Assets.icons.profileIconOff.path,
      name: "Profil",
    ),
  ];

  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  void changeNavigationIndex(int newIndex) {
    _currentIndex.value = newIndex;
  }
}
