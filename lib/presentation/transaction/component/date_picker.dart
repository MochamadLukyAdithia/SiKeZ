import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/presentation/transaction/controller/add_transaction_controller.dart';
import 'package:hmj_apps/resources/assets.gen.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends GetView<AddTransactionController> {
  const CustomDatePicker({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
            gradient: AppColors.secondaryGradient,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Assets.icons.solarCalendarBold.svg(width: 24, height: 24),
            const SizedBox(
              width: 12,
            ),
            GestureDetector(
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now(),
                );
                if (selectedDate != null) {
                  controller.setSelectedDate = selectedDate;
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tanggal",
                    style: AppTextStyle.body4,
                  ),
                  Text(
                    DateFormat.yMMMd().format(controller.selectedDate),
                    style: AppTextStyle.body2
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              color: Colors.black26,
              height: 35,
              width: 2,
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () async {
                final selectedTime = await showTimePicker(
                    context: context, initialTime: controller.selectedTime);

                if (selectedTime != null) {
                  controller.setSelectedTimeOfDay = selectedTime;
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Waktu",
                    style: AppTextStyle.body4,
                  ),
                  Text(
                    controller.selectedTime.format(context),
                    style: AppTextStyle.body2
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.edit,
              color: AppColors.tertiaryColor,
            )
          ],
        ),
      ),
    );
  }
}
