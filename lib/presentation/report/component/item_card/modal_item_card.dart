import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_modal_controller.dart';

class ModalItemCard extends GetView<ReportModalController> {
  const ModalItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final modalData = controller.getReport();
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(2, 2))
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Perubahan Modal",
              style: AppTextStyle.body3.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.secondaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 3,
                  height: 70,
                  color: AppColors.primaryColor,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Modal Awal",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            modalData.modalAwal.toString().currentcy,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Penambahan Modal",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          Text(
                            modalData.addedModalAmount.toString().currentcy,
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Laba Bersih",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          Text(
                            (modalData.cleanLaba > 0 ? modalData.cleanLaba : 0)
                                .toString()
                                .currentcy,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Total Penambahan",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ),
                          Text(
                            (max(modalData.cleanLaba, 0) +
                                    modalData.addedModalAmount)
                                .toString()
                                .currentcy,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Pengambilan Modal",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          Text(
                            modalData.takedModalAmount.toString().currentcy,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Rugi Bersih",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          Text(
                            min(modalData.cleanLaba, 0).toString().currentcy,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Total Pengambilan",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ),
                          Text(((modalData.cleanLaba < 0
                                      ? modalData.cleanLaba
                                      : 0) +
                                  modalData.takedModalAmount)
                              .toString()
                              .currentcy),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Perubahan Modal",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            (modalData.getModalAkhir - modalData.modalAwal)
                                .toString()
                                .currentcy,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Modal Akhir",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            modalData.getModalAkhir.toString().currentcy,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
