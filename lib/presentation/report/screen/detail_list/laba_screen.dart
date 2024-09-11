import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/date_filter.dart';
import 'package:hmj_apps/presentation/report/component/item_card/laba_item_card.dart';
import 'package:hmj_apps/presentation/report/component/row_text.dart';
import 'package:hmj_apps/presentation/report/controller/report_laba_controller.dart';

class LabaRugiListScreen extends GetView<ReportLabaRugiController> {
  const LabaRugiListScreen({super.key});

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
        title: const Text("Laba Rugi"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              Get.toNamed(AppRoute.pdfLabaPreview);
            },
          )
        ],
      ),
      body: AspectRatio(
        aspectRatio: 16 / 20,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const DateFilter("labarRugi"),
              LabaItemCard(
                title: "Pendapatan dari Penjualan",
                datalist: controller.dataLabarugi?.pendapatanPenjualan ?? [],
                total: controller.listTotal[0].total,
              ),
              LabaItemCard(
                title: "Harga Pokok Penjualan",
                datalist: controller.dataLabarugi?.hargaPokokPenjualan ?? [],
                total: controller.listTotal[1].total,
              ),
              LabaItemCard(
                title: "Beban Operasional",
                datalist: controller.dataLabarugi?.bebanOperasional ?? [],
                total: controller.listTotal[2].total,
              ),
              LabaItemCard(
                title: "Pendapatan Lainnya",
                datalist: controller.dataLabarugi?.pendapatanLainnya ?? [],
                total: controller.listTotal[3].total,
              ),
              LabaItemCard(
                title: "Beban Lainnya",
                datalist: controller.dataLabarugi?.bebanLainnya ?? [],
                total: controller.listTotal[4].total,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: AspectRatio(
        aspectRatio: 16 / 9.5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              RowText(
                  isBold: false,
                  title: "Pendapatan Dari Penjualan",
                  nominal:
                      controller.listTotal[0].total.abs().toString().currentcy),
              RowText(
                  isBold: false,
                  title: "Harga Pokok Penjualan",
                  nominal: controller.listTotal[1].total.toString()),
              const Divider(),
              RowText(
                  isBold: true,
                  title: "Laba Kotor",
                  nominal:
                      "${controller.listTotal[0].total.abs() - controller.listTotal[1].total.abs()}"
                          .currentcy),
              const SizedBox(
                height: 5,
              ),
              RowText(
                  isBold: false,
                  title: "Beban Operasional",
                  nominal: controller.listTotal[2].total.toString()),
              const Divider(),
              RowText(
                  isBold: true,
                  title: "Laba Beban Operasional",
                  nominal:
                      "${(controller.listTotal[0].total.abs() - controller.listTotal[1].total.abs()) - controller.listTotal[2].total.abs()}"
                          .currentcy),
              const SizedBox(
                height: 5,
              ),
              RowText(
                  isBold: false,
                  title: "Pendapatan Lainnya",
                  nominal: controller.listTotal[3].total.toString()),
              RowText(
                  isBold: false,
                  title: "Beban Lainnya",
                  nominal: controller.listTotal[4].total.toString()),
              const Divider(),
              RowText(
                  isBold: true,
                  title: "Laba Bersih",
                  nominal:
                      "${((controller.listTotal[0].total.abs() - controller.listTotal[1].total.abs()) - controller.listTotal[2].total.abs()) - controller.listTotal[3].total.abs() - controller.listTotal[4].total.abs()}"
                          .currentcy),
            ],
          ),
        ),
      ),
    );
  }
}
