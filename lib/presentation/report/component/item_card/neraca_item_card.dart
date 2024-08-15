import 'package:flutter/material.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';

class NeracaItemCard extends StatelessWidget {
  const NeracaItemCard({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Aset",
            style: AppTextStyle.body2.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.secondaryColor),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5),
                width: 3,
                height: 20,
                color: AppColors.primaryColor,
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1-1100 Kas",
                      style: TextStyle(color: Colors.black54),
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Text(
                    //   "Total Modal",
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold, color: Colors.black54),
                    // ),
                  ],
                ),
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Rp 20.000.000",
                      style: TextStyle(color: Colors.black54),
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Text(
                    //   "Rp 21.000.000",
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold, color: Colors.black54),
                    // )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                "TOTAL ASET",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  color: AppColors.primaryColor,
                  height: 2,
                ),
              ),
              const Text(
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
