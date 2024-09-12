import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/date_filter_from_controller.dart';
import 'package:hmj_apps/presentation/report/component/item_card/jurnal_item_card.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_journal_controller.dart';
import 'package:hmj_apps/presentation/shared/custom_empty_warning.dart';
import 'package:intl/intl.dart';

class JurnalListScreen extends GetView<ReportJournalController> {
  const JurnalListScreen({super.key});

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
        title: const Text("Jurnal Umum"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          DateFilterFromController(
            controller: controller,
          ),
          Expanded(
            child: Obx(() {
              final transactionList = controller.getReport();
              if (transactionList.isEmpty) return const EmptyWarning();
              return ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (context, index) {
                    var transactionData = transactionList[index];
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
                      height: 12,
                    );
                  },
                  itemCount: transactionList.length);
            }),
          )
        ],
      ),
    );
  }
}
