import 'package:flutter/material.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/presentation/report/model/neraca_model.dart';

class NeracaDoubleItemCard extends StatelessWidget {
  final List<Neraca> hutang;
  final List<Neraca> modal;
  final int totalHutang;
  final int totalModal;
  final int totalAll;
  const NeracaDoubleItemCard(
      {super.key,
      required this.hutang,
      required this.modal,
      required this.totalHutang,
      required this.totalModal,
      required this.totalAll});

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
            "Hutang",
            style: AppTextStyle.body2.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.secondaryColor),
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Neraca dataHutang = hutang[index];
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
                      child: Text(
                        "${dataHutang.kode} ${dataHutang.nama}",
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        dataHutang.nominal.toString().currentcy,
                        style: const TextStyle(color: Colors.black54),
                        textAlign: TextAlign.right,
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
              itemCount: hutang.length),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Hutang",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              Text(
                totalHutang.toString().currentcy,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Modal",
            style: AppTextStyle.body2.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.secondaryColor),
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Neraca dataModal = modal[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 3,
                      height: 40,
                      color: AppColors.primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        "${dataModal.kode} ${dataModal.nama}",
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${dataModal.nominal}".currentcy,
                        style: const TextStyle(color: Colors.black54),
                        textAlign: TextAlign.right,
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
              itemCount: modal.length),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Modal",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              Text(
                totalModal.toString().currentcy,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                "TOTAL HUTANG DAN MODAL",
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
                totalAll.toString().currentcy,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
