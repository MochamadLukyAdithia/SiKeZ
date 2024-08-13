import 'package:flutter/material.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/date_filter.dart';
import 'package:hmj_apps/presentation/report/component/item_card/laba_item_card.dart';
import 'package:hmj_apps/presentation/report/component/item_card/laba_total_item.dart';
import 'package:hmj_apps/presentation/report/component/row_text.dart';

class LabaRugiListScreen extends StatelessWidget {
  const LabaRugiListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Laba Rugi"),
         actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [DateFilter("labarRugi"), LabaItemCard(), LabaTotalItemCard()],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height / 4 + 45,
        child: Column(
          children: [
            RowText(
                isBold: false,
                title: "Pendapatan Dari Penjualan",
                nominal: "Rp20000"),
            RowText(
                isBold: false,
                title: "Harga Pokok Penjualan",
                nominal: "Rp20000"),
            Divider(),
            RowText(isBold: true, title: "Laba Kotor", nominal: "Rp30000"),
            const SizedBox(
              height: 5,
            ),
            RowText(isBold: false, title: "Beban Operasional", nominal: "Rp0"),
            Divider(),
            RowText(
                isBold: true,
                title: "Laba Beban Operasional",
                nominal: "Rp30000"),
            const SizedBox(
              height: 5,
            ),
            RowText(isBold: false, title: "Pendapatan Lainnya", nominal: "Rp0"),
            RowText(isBold: false, title: "Beban Lainnya", nominal: "Rp0"),
            Divider(),
            RowText(isBold: true, title: "Laba Bersih", nominal: "Rp30000"),
          ],
        ),
      ),
    );
  }
}
