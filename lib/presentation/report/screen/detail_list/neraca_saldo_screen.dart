import 'package:flutter/material.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/presentation/report/component/date_filter.dart';
import 'package:hmj_apps/presentation/report/component/item_card/neraca_saldo_item_card.dart';

class NeracaSaldoListScreen extends StatelessWidget {
  const NeracaSaldoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Neraca Saldo"),
         actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [DateFilter("neracaSaldo"), NecaraSaldoItemCard()],
        ),
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height / 6 - 75,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: AppTextStyle.body2.copyWith(fontWeight: FontWeight.bold),
            ),
            // Container(
            //   color: AppColors.primaryColor,
            //   width: 2,
            //   height: MediaQuery.of(context).size.height / 6 - 80,
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Debit',
                ),
                Text(
                  "Rp.200000",
                  style:
                      AppTextStyle.body3.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kredit'),
                Text(
                  "Rp.200000",
                  style:
                      AppTextStyle.body3.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
