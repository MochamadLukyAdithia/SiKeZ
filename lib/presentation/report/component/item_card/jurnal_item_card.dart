import 'package:flutter/material.dart';
import 'package:hmj_apps/core/helper/format_currency.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';

class JurnalItemCard extends StatelessWidget {
  final String jenisTransaksi;
  final String catatan;
  final String debitName;
  final String kreditName;
  final int nominal;
  final String tanggal;
  const JurnalItemCard(
      {super.key,
      required this.jenisTransaksi,
      required this.catatan,
      required this.debitName,
      required this.kreditName,
      required this.nominal,
      required this.tanggal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Row(
            children: [
              Text(
                jenisTransaksi,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Spacer(),
              Text(tanggal)
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(catatan),
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
                      "$debitName (D)",
                      style: const TextStyle(color: AppColors.secondaryColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.subdirectory_arrow_right,
                          color: Colors.black26,
                        ),
                        Text(formatCurrency(nominal)),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "$kreditName(C)",
                      style: const TextStyle(color: AppColors.secondaryColor),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.subdirectory_arrow_right,
                          color: Colors.black26,
                        ),
                        Text(formatCurrency(nominal)),
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
