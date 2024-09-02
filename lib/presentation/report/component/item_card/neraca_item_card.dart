import 'package:flutter/material.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/presentation/report/model/neraca_model.dart';

class NeracaItemCard extends StatelessWidget {
  final List<Neraca> dataItem;
  final int totalAset;
  const NeracaItemCard(
      {super.key, required this.dataItem, required this.totalAset});

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
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Neraca dataIdxItem = dataItem[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 3,
                      height: 20,
                      color: AppColors.primaryColor,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${dataIdxItem.kode} ${dataIdxItem.nama}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${dataIdxItem.nominal}".currentcy,
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: dataItem.length),
          const SizedBox(
            height: 20,
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
              Text(
                totalAset.toString().currentcy,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
