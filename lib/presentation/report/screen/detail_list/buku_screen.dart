import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/date_filter.dart';
import 'package:hmj_apps/presentation/report/component/item_card/buku_item_card.dart';
import 'package:hmj_apps/presentation/report/controller/report_buku_controller.dart';

class BukuBesarListScreen extends GetView<BukuBesarController> {
  const BukuBesarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        foregroundColor: Colors.white,
        title: const Text("Buku Besar"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            DateFilter("bukuBesar"),
            InkWell(
                onTap: () {
                  controller.getTransactionAccountHistoryData();
                },
                child: BukuItemCard())
          ],
        ),
      ),
    );
  }
}
