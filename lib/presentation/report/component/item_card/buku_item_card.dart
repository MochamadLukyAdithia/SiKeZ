import 'package:flutter/material.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';

class BukuItemCard extends StatelessWidget {
  const BukuItemCard({super.key});

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
                height: 70,
                color: AppColors.primaryColor,
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tanggal",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "31 Jul 24",
                      style: AppTextStyle.body4,
                    ),
                    Text(
                      "Saldo Awal",
                      style: AppTextStyle.body4,
                    )
                  ],
                ),
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Debit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Rp500000",
                      style: AppTextStyle.body4,
                    )
                  ],
                ),
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Credit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Rp500000",
                      style: AppTextStyle.body4,
                    )
                  ],
                ),
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Saldo",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Rp0",
                      style: AppTextStyle.body4,
                    )
                  ],
                ),
              ),
            ],
          ),
          const Row(
            children: [
              Text(
                "Saldo Akhir",
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
