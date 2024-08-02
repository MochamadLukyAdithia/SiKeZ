import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt currentIndex = 0.obs;

  void changeNavigationIndex(int newIndex) {
    currentIndex.value = newIndex;
  }
}
