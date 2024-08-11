import 'package:flutter/material.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
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
      ),
      body: Container(
        child: const Column(
          children: [DateFilter(), NecaraSaldoItemCard()],
        ),
      ),
    );
  }
}
