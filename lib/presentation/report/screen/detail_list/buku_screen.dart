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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DateFilter("bukuBesar"),
            Obx(
              () => ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var bukuBesarData = controller.bukuBesarData[index];
                    int dataSaldoAkhir =  controller.getSumHistoryNominalData(index);
                    return InkWell(
                      onTap: () {
                       
                      },
                      child: BukuItemCard(
                        saldo: dataSaldoAkhir,
                        accountName: bukuBesarData["account"] ?? "kosong",
                        accountCode:
                            bukuBesarData["account_number"] ?? "kosong",
                        date: "31 Jul 24",
                        history: bukuBesarData["history"],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: controller.bukuBesarData.length),
            )
            // InkWell(
            //     onTap: () {
            //       controller.getTransactionAccountHistoryData();
            //     },
            //     child: BukuItemCard())
          ],
        ),
      ),
    );
  }
}
