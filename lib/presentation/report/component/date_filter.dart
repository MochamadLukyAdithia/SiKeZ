import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/controller/report_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_jurnal_controller.dart';
import 'package:intl/intl.dart';

class DateFilter extends GetView<ReportController> {
  final String page;
  const DateFilter(this.page, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(10),
        color: AppColors.primaryColor.withOpacity(0.4),
        child: Row(
          children: [
            const Icon(Icons.date_range),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: DropdownButton(
                  value: controller.choosedFilter.value,
                  items: [
                    DropdownMenuItem(
                      value: "01",
                      child: Row(
                        children: [
                          const Text(
                            "Hari ini",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(DateFormat.yMMMd().format(DateTime.now()))
                        ],
                      ),
                    ),
                    for (var i = 0;
                        i < controller.chosedFilterListForPage(page).length;
                        i++)
                      DropdownMenuItem(
                        value: controller.chosedFilterListForPage(page)[i],
                        child: Row(
                          children: [
                            Text(
                              controller.chosedFilterListForPage(page)[i],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // Text("08 Agu 2024")
                          ],
                        ),
                      )
                  ],
                  onChanged: (value) {
                    controller.changeDate(value.toString());
                    if (value == "Kemarin") {
                      Get.find<ReportJurnalController>()
                          .getTransactionYesterday();
                    } else if (value == "7 Hari Terakhir") {
                      Get.find<ReportJurnalController>()
                          .getTransactionInAWeek();
                    } else if (value == "30 Hari Terakhir") {
                      Get.find<ReportJurnalController>()
                          .getTransactionThirtyDays();
                    } else if (value == "Bulan ini") {
                      Get.find<ReportJurnalController>()
                          .getTransactionInAMonth();
                    } else if (value == "Bulan lalu") {
                      Get.find<ReportJurnalController>()
                          .getTransactionInAPreivousMonth();
                    } else if (value == "01") {
                      Get.find<ReportJurnalController>().getTransactionToday();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
