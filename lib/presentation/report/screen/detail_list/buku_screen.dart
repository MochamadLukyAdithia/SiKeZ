import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/date_filter_from_controller.dart';
import 'package:hmj_apps/presentation/report/component/item_card/buku_item_card.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_book_controller.dart';
import 'package:hmj_apps/presentation/shared/custom_empty_warning.dart';

class BukuBesarListScreen extends GetView<ReportBookController> {
  const BukuBesarListScreen({super.key});

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
        title: const Text("Buku Besar"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          DateFilterFromController(controller: controller),
          Expanded(
            child: Obx(
              () {
                final data = controller.getReport();
                if (data.isEmpty) {
                  return const EmptyWarning();
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  itemBuilder: (context, index) {
                    var book = data[index];
                    int finalAmount = 0;
                    for (var element in book.history) {
                      finalAmount += element.debit;
                      finalAmount -= element.kredit;
                    }
                    return InkWell(
                      onTap: () {},
                      child: BukuItemCard(
                        saldo: finalAmount,
                        accountName: book.account,
                        accountCode: book.code,
                        history: book.history,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: data.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
