import 'package:flutter/material.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_laba_controller.dart';

class LabaItemCard extends StatelessWidget {
  final String title;
  final List<LabaItemModel> datalist;
  final int total;
  const LabaItemCard({
    super.key,
    required this.title,
    required this.datalist,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            title,
            style: AppTextStyle.body3.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.secondaryColor),
          ),
          const SizedBox(
            height: 12,
          ),
          ...List.generate(datalist.length, (index) {
            final data = datalist[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 3,
                  height: 30,
                  color: AppColors.primaryColor,
                ),
                Expanded(
                  child: Text(
                    "${data.code} ${data.name}",
                    style: AppTextStyle.body4,
                  ),
                ),
                Text(
                  data.amount.abs().toString().currentcy,
                  style: AppTextStyle.body4,
                ),
              ]),
            );
          }),
          Row(
            children: [
              const Text(
                "Total",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                total.abs().toString().currentcy,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
