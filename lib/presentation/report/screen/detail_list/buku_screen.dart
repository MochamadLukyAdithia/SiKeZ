import 'package:flutter/material.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/date_filter.dart';
import 'package:hmj_apps/presentation/report/component/item_card/buku_item_card.dart';

class BukuBesarListScreen extends StatelessWidget {
  const BukuBesarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Buku Besar"),
      ),
      body: Container(
        child: Column(
          children: [DateFilter(), BukuItemCard()],
        ),
      ),
    );
  }
}
