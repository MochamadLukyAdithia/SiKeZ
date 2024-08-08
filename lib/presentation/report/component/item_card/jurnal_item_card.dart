import 'package:flutter/material.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/date_filter.dart';

class JurnalItemCard extends StatelessWidget {
  const JurnalItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(2, 2))
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Pemasukan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Spacer(),
              Text("08 Agu 2024")
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text("title transaction"),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 5),
                width: 3,
                height: 90,
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "5-50000 Beban Pokok Pendapatan (D)",
                      style: TextStyle(color: AppColors.secondaryColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.subdirectory_arrow_right,
                          color: Colors.black26,
                        ),
                        Text("Rp 25.000.000"),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "1-10000 Beban Pokok",
                      style: TextStyle(color: AppColors.secondaryColor),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.subdirectory_arrow_right,
                          color: Colors.black26,
                        ),
                        Text("Rp 25.000.000"),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
