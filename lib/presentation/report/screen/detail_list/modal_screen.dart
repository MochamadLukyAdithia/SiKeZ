import 'package:flutter/material.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/date_filter.dart';
import 'package:hmj_apps/presentation/report/component/item_card/modal_item_card.dart';

class ModalListScreen extends StatelessWidget {
  const ModalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 129, 145, 100),
              AppColors.primaryColor
            ], stops: [
              0.01,
              // 0.5,
              0.6
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        title: const Text("Perubahan Modal"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: const Column(
          children: [DateFilter("modal"), ModalItemCard()],
        ),
      ),
    );
  }
}
