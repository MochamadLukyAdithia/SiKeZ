import 'package:get/get.dart';
import 'package:hmj_apps/presentation/transaction/controller/add_transaction_controller.dart';

class AddTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTransactionController());
  }
}
