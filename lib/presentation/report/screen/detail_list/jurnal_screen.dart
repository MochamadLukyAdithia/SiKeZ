import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/date_filter.dart';
import 'package:hmj_apps/presentation/report/component/item_card/jurnal_item_card.dart';
import 'package:hmj_apps/presentation/report/controller/report_jurnal_controller.dart';
import 'package:intl/intl.dart';

class JurnalListScreen extends GetView<ReportJurnalController> {
  const JurnalListScreen({super.key});

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
        title: const Text("Jurnal Umum"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              Get.toNamed(AppRoute.pdfJurnalUmumPreview);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DateFilter("jurnal"),
            Obx(
              () => ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var transactionData = controller.transactionList[index];
                    return JurnalItemCard(
                      catatan: transactionData.notes,
                      debitName:
                          "${transactionData.debitCode} ${transactionData.debitName}",
                      jenisTransaksi: transactionData.transactionName,
                      kreditName:
                          "${transactionData.creditCode} ${transactionData.creditName}",
                      nominal: transactionData.nominal,
                      tanggal: DateFormat.yMMMd().format(transactionData.date),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: controller.transactionList.length),
            )
          ],
        ),
      ),
    );
  }
}
