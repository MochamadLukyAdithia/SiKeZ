import 'package:flutter/material.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/date_filter.dart';
import 'package:hmj_apps/presentation/report/component/item_card/jurnal_item_card.dart';

class JurnalListScreen extends StatelessWidget {
  const JurnalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 129, 145, 100),
              AppColors.primaryColor
            ], stops: [
              0.01,
              // 0.5,
              0.6
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        title: const Text("Jurnal Umum"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: const Column(
          children: [DateFilter("jurnal"), JurnalItemCard()],
        ),
      ),
    );
  }
}
