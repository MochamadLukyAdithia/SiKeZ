import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/date_extension.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_base_controller.dart';
import 'package:intl/intl.dart';

class DateFilterFromController extends StatelessWidget {
  const DateFilterFromController({
    super.key,
    required this.controller,
  });

  final ReportBaseController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.secondaryGradient,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(
            Icons.calendar_month_rounded,
            color: Colors.grey,
          ),
          const SizedBox(width: 16),
          Obx(
            () => Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton(
                    value: controller.currentFilter.value,
                    items: controller.getDropdownMenuItems(),
                    onChanged: controller.onChangeFilter,
                  ),
                  if (controller.currentFilter.value == FilterMode.selectMonth)
                    DropdownButton(
                      value: controller.selectedMonth.value,
                      items: List.generate(
                        12,
                        (index) => DropdownMenuItem(
                          value: index + 1,
                          child: Text(
                            DateFormat("MMMM").format(
                              DateTime(2024, index + 1),
                            ),
                          ),
                        ),
                      ),
                      onChanged: (newMonth) {
                        controller.selectedMonth.value = newMonth ?? 1;
                      },
                    ),
                  if (controller.currentFilter.value ==
                      FilterMode.selectRangeMonth)
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButton(
                            value: controller.firstRangedMonth.value,
                            items: List.generate(
                              12,
                              (index) => DropdownMenuItem(
                                value: index + 1,
                                child: Text(
                                  DateFormat("MMMM").format(
                                    DateTime(2024, index + 1),
                                  ),
                                ),
                              ),
                            ),
                            onChanged: (newMonth) {
                              controller.firstRangedMonth.value = newMonth ?? 1;
                            },
                          ),
                        ),
                        Expanded(
                          child: DropdownButton(
                            value: controller.secondRangedMonth.value,
                            items: List.generate(
                              12,
                              (index) => DropdownMenuItem(
                                value: index + 1,
                                child: Text(
                                  DateFormat("MMMM").format(
                                    DateTime(2024, index + 1),
                                  ),
                                ),
                              ),
                            ),
                            onChanged: (newMonth) {
                              controller.secondRangedMonth.value =
                                  newMonth ?? 1;
                            },
                          ),
                        ),
                      ],
                    ),
                  if (controller.currentFilter.value ==
                      FilterMode.selectRangeDate)
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 365)),
                                lastDate: DateTime.now(),
                                initialDate: controller.firstRangedDate.value,
                              ).then((value) {
                                if (value != null) {
                                  controller.firstRangedDate.value = value;
                                }
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.borderColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                controller.firstRangedDate.value.toddMMMyyyy(),
                                style: Get.textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text("hingga"),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 365)),
                                lastDate: DateTime.now(),
                                initialDate: controller.secondRangedDate.value,
                              ).then((value) {
                                if (value != null) {
                                  controller.secondRangedDate.value = value;
                                }
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.borderColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                controller.secondRangedDate.value.toddMMMyyyy(),
                                style: Get.textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
