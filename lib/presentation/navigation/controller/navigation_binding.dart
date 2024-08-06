import 'package:get/get.dart';
import 'package:hmj_apps/core/injector/injector.dart';
import 'package:hmj_apps/presentation/navigation/controller/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<NavigationController>());
  }
}
