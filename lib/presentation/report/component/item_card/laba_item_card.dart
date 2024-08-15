import 'package:flutter/material.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';

class LabaItemCard extends StatelessWidget {
  const LabaItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(2, 2))
      ]),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "nama akun",
                style: AppTextStyle.body3.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor),
              ),
              const Spacer(),
              Text(
                "1-00002",
                style: AppTextStyle.body3.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5),
                width: 3,
                height: 30,
                color: AppColors.primaryColor,
              ),
              const Expanded(
                child: Text(
                  "4-40000 Pendapatan",
                  style: AppTextStyle.body4,
                ),
              ),
              const Text(
                "Rp500000",
                style: AppTextStyle.body4,
              ),
            ],
          ),
          const Row(
            children: [
              Text(
                "Total",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "Rp800000",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
