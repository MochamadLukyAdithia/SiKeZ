import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';

class SiKePeLinearButton extends StatelessWidget {
  const SiKePeLinearButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.linearGradient,
    this.color,
    this.customWidget,
  });

  final String title;
  final Function() onPressed;
  final Color? color;
  final Widget? customWidget;
  final LinearGradient? linearGradient;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: linearGradient ?? AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Get.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: color ?? Colors.white,
              ),
            ),
            if (customWidget != null) ...[
              const SizedBox(
                width: 8,
              ),
              customWidget!,
            ]
          ],
        ),
      ),
    );
  }
}
