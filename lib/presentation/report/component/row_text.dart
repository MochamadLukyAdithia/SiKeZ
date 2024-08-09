import 'package:flutter/material.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';

class RowText extends StatelessWidget {
  final bool isBold;
  final String title;
  final String nominal;
  const RowText(
      {super.key,
      required this.isBold,
      required this.title,
      required this.nominal});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
            style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        const Spacer(),
        Text(
          nominal,
          style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }
}
