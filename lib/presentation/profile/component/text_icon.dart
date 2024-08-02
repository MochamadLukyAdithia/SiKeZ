import 'package:flutter/material.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';

class TextIcon extends StatelessWidget {
  final IconData icon;
  final String dataText;
  const TextIcon({super.key, required this.icon, required this.dataText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            dataText,
            style: AppTextStyle.body2
                .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
          ),
        )
      ],
    );
  }
}
