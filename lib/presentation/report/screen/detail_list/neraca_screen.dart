import 'package:flutter/material.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/date_filter.dart';
import 'package:hmj_apps/presentation/report/component/item_card/neraca_double_item_card.dart';
import 'package:hmj_apps/presentation/report/component/item_card/neraca_item_card.dart';

class NeracaListScreen extends StatelessWidget {
  const NeracaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Neraca"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            DateFilter("neraca"),
            NeracaItemCard(),
            NeracaDoubleItemCard()
          ],
        ),
      ),
    );
  }
}
