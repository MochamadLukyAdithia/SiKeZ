import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/presentation/report/component/item_card/neraca_saldo_item_card.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_neraca_saldo_controller.dart';

class NeracaSaldoListScreen extends GetView<ReportNeracaSaldoController> {
  const NeracaSaldoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var neracaSaldoData = controller.getAllReport();
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        foregroundColor: Colors.white,
        title: const Text("Neraca Saldo"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              Get.toNamed(AppRoute.pdfNeracaSaldoPreview);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return NecaraSaldoItemCard(data: neracaSaldoData[index]);
              },
              itemCount: neracaSaldoData.length,
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AppColors.secondaryGradient,
          border: Border.all(
            color: AppColors.borderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: AppTextStyle.body2.copyWith(fontWeight: FontWeight.bold),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Debit',
                ),
                Text(
                  neracaSaldoData
                      .fold(
                          0,
                          (previousValue, element) =>
                              previousValue + element.debit)
                      .toString()
                      .currentcy,
                  style:
                      AppTextStyle.body3.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Kredit'),
                Text(
                  neracaSaldoData
                      .fold(
                          0,
                          (previousValue, element) =>
                              previousValue + element.credit)
                      .toString()
                      .currentcy,
                  style:
                      AppTextStyle.body3.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
