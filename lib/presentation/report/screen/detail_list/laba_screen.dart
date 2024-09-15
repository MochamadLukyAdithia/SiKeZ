import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/presentation/report/component/date_filter_from_controller.dart';
import 'package:hmj_apps/presentation/report/component/item_card/laba_item_card.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_laba_controller.dart';

class LabaRugiListScreen extends GetView<ReportLabaController> {
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
              onPressed: () {},
            )
          ],
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
              DateFilterFromController(controller: controller),
              Expanded(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    LabaItemCard(
                      title: data.pendapatanDariPenjualan.name,
                      datalist: data.pendapatanDariPenjualan.items,
                      total: data.pendapatanDariPenjualan.totalAmount,
                    ),
                    const SizedBox(height: 12),
                    LabaItemCard(
                      title: data.bebanOperasional.name,
                      datalist: data.bebanOperasional.items,
                      total: data.bebanOperasional.totalAmount,
                    ),
                    const SizedBox(height: 12),
                    LabaItemCard(
                      title: data.bebanLainya.name,
                      datalist: data.bebanLainya.items,
                      total: data.bebanLainya.totalAmount,
                    ),
                  ],
                ),
              )),

              // LabaItemCard(
              //   title: "Beban Operasional",
              //   datalist: controller.dataLabarugi?.bebanOperasional ?? [],
              //   total: controller.listTotal[2].total,
              // ),
              // LabaItemCard(
              //   title: "Pendapatan Lainnya",
              //   datalist: controller.dataLabarugi?.pendapatanLainnya ?? [],
              //   total: controller.listTotal[3].total,
              // ),
              // LabaItemCard(
              //   title: "Beban Lainnya",
              //   datalist: controller.dataLabarugi?.bebanLainnya ?? [],
              //   total: controller.listTotal[4].total,
              // ),
              Container(
                decoration: BoxDecoration(
                  gradient: AppColors.secondaryGradient,
                  border: Border.all(color: AppColors.borderColor),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "Pendapatan dari Penjualan",
                          style: AppTextStyle.body3,
                        )),
                        Text(
                          data.pendapatanDariPenjualan.totalAmount
                              .toString()
                              .currentcy,
                          style: AppTextStyle.body3,
                        )
                      ],
                    ),
                    const Divider(
                      color: AppColors.borderColor,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Laba Kotor",
                            style: AppTextStyle.body3.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          data.pendapatanDariPenjualan.totalAmount
                              .toString()
                              .currentcy,
                          style: AppTextStyle.body3.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "Beban Operasional",
                          style: AppTextStyle.body3,
                        )),
                        Text(
                          data.bebanOperasional.totalAmount
                              .toString()
                              .currentcy,
                          style: AppTextStyle.body3,
                        )
                      ],
                    ),
                    const Divider(
                      color: AppColors.borderColor,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Laba Beban Operasional",
                            style: AppTextStyle.body3.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          (data.pendapatanDariPenjualan.totalAmount -
                                  data.bebanOperasional.totalAmount)
                              .toString()
                              .currentcy,
                          style: AppTextStyle.body3.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "Beban Lainya",
                          style: AppTextStyle.body3,
                        )),
                        Text(
                          data.bebanLainya.totalAmount.toString().currentcy,
                          style: AppTextStyle.body3,
                        )
                      ],
                    ),
                    const Divider(
                      color: AppColors.borderColor,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Laba Bersih",
                            style: AppTextStyle.body3.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          data.cleanResult.toString().currentcy,
                          style: AppTextStyle.body3.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          );

          // bottomSheet: AspectRatio(
          //   aspectRatio: 16 / 9.5,
          //   child: Padding(
          //     padding: const EdgeInsets.all(10),
          //     child: Column(
          //       children: [
          //         RowText(
          //             isBold: false,
          //             title: "Pendapatan Dari Penjualan",
          //             nominal:
          //                 controller.listTotal[0].total.abs().toString().currentcy),
          //         RowText(
          //             isBold: false,
          //             title: "Harga Pokok Penjualan",
          //             nominal: controller.listTotal[1].total.toString()),
          //         const Divider(),
          //         RowText(
          //             isBold: true,
          //             title: "Laba Kotor",
          //             nominal:
          //                 "${controller.listTotal[0].total.abs() - controller.listTotal[1].total.abs()}"
          //                     .currentcy),
          //         const SizedBox(
          //           height: 5,
          //         ),
          //         RowText(
          //             isBold: false,
          //             title: "Beban Operasional",
          //             nominal: controller.listTotal[2].total.toString()),
          //         const Divider(),
          //         RowText(
          //             isBold: true,
          //             title: "Laba Beban Operasional",
          //             nominal:
          //                 "${(controller.listTotal[0].total.abs() - controller.listTotal[1].total.abs()) - controller.listTotal[2].total.abs()}"
          //                     .currentcy),
          //         const SizedBox(
          //           height: 5,
          //         ),
          //         RowText(
          //             isBold: false,
          //             title: "Pendapatan Lainnya",
          //             nominal: controller.listTotal[3].total.toString()),
          //         RowText(
          //             isBold: false,
          //             title: "Beban Lainnya",
          //             nominal: controller.listTotal[4].total.toString()),
          //         const Divider(),
          //         RowText(
          //             isBold: true,
          //             title: "Laba Bersih",
          //             nominal:
          //                 "${((controller.listTotal[0].total.abs() - controller.listTotal[1].total.abs()) - controller.listTotal[2].total.abs()) - controller.listTotal[3].total.abs() - controller.listTotal[4].total.abs()}"
          //                     .currentcy),
          //       ],
          //     ),
          //   ),
          // ),
        }));
  }
}
