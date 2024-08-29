import 'package:flutter/material.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/presentation/report/model/laba_rugi_model.dart';

class LabaItemCard extends StatelessWidget {
  final String title;
  final List<AkunItem> datalist;
  final int total;
  const LabaItemCard(
      {super.key,
      required this.title,
      required this.datalist,
      required this.total});

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
            title,
            style: AppTextStyle.body3.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.secondaryColor),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                AkunItem data = datalist[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 3,
                      height: 30,
                      color: AppColors.primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        "${data.code} ${data.nama}",
                        style: AppTextStyle.body4,
                      ),
                    ),
                    Text(
                      data.total.abs().toString().currentcy,
                      style: AppTextStyle.body4,
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: datalist.length),
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
