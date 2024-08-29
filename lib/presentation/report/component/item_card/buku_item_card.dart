import 'package:flutter/material.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';

class BukuItemCard extends StatelessWidget {
  final String accountName;
  final String accountCode;
  final String date;
  final List history;
  final int saldo;
  const BukuItemCard(
      {super.key,
      required this.accountName,
      required this.accountCode,
      required this.date,
      required this.history,
      required this.saldo});

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
                accountName,
                style: AppTextStyle.body3.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor),
              ),
              const Spacer(),
              Text(
                accountCode,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tanggal",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        return Text(
                          history[index]["date"],
                          style: AppTextStyle.body4,
                        );
                      },
                    ),
                    const Text(
                      "Saldo Awal",
                      style: AppTextStyle.body4,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Debit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        return Text(
                          history[index]["debit"].toString().currentcy,
                          style: AppTextStyle.body4,
                          textAlign: TextAlign.end,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Credit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        return Text(
                          history[index]["kredit"].toString().currentcy,
                          style: AppTextStyle.body4,
                          textAlign: TextAlign.end,
                        );
                      },
                    ),
                  ],
                ),
              ),
              // const Expanded(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       Text(
              //         "Saldo",
              //         style: TextStyle(fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(
              //         height: 5,
              //       ),
              //       Text(
              //         "Rp0",
              //         style: AppTextStyle.body4,
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
          Row(
            children: [
              const Text(
                "Saldo Akhir",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                saldo < 0
                    ? "(${saldo.abs().toString().currentcy})"
                    : saldo.toString().currentcy,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
