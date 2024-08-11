import 'package:flutter/material.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';

class DateFilter extends StatelessWidget {
  const DateFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                value: "01",
                items: const [
                  DropdownMenuItem(
                    value: "01",
                    child: Row(
                      children: [
                        Text(
                          "Hari ini",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("08 Agu 2024")
                      ],
                    ),
                  )
                ],
                onChanged: (value) {}),
          )
        ],
      ),
    );
  }
}
