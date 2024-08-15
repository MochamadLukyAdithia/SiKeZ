import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/resources/assets.gen.dart';

class DropDownButtonWithSearch extends StatelessWidget {
  final String title;
  final String? value;
  final Function() onTap;

  const DropDownButtonWithSearch({
    super.key,
    required this.onTap,
    required this.title,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.borderColor,
              ),
              borderRadius: BorderRadius.circular(12),
              gradient: AppColors.secondaryGradient,
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value ?? "",
                  ),
                ),
                Assets.icons.dropdownIcon.svg(
                  width: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
