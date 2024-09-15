import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/date_filter_from_controller.dart';
import 'package:hmj_apps/presentation/report/component/item_card/modal_item_card.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_modal_controller.dart';

class ModalListScreen extends GetView<ReportModalController> {
  const ModalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        foregroundColor: Colors.white,
        title: const Text("Perubahan Modal"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              Get.toNamed(AppRoute.pdfModalPreview);
            },
          )
        ],
      ),
      body: Column(
        children: [
          DateFilterFromController(controller: controller),
          const Expanded(
            child: ModalItemCard(),
          ),
        ],
      ),
    );
  }
}
