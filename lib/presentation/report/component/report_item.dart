import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';

class ReportItem extends StatelessWidget {
  final String title;
  final String route;
  const ReportItem({super.key, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(route),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: AppColors.secondaryGradient,
          border: Border.all(
            width: 1,
            color: AppColors.borderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Get.textTheme.titleMedium,
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.tertiaryColor,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
