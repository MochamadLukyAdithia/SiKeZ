import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/presentation/report/component/date_filter.dart';
import 'package:hmj_apps/presentation/report/component/item_card/neraca_saldo_item_card.dart';
import 'package:hmj_apps/presentation/report/controller/report_neraca_saldo_controller.dart';

class NeracaSaldoListScreen extends GetView<NeracaSaldoController> {
  const NeracaSaldoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var total = controller.getTotalDebitKredit();
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        foregroundColor: Colors.white,
        title: const Text("Neraca Saldo"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DateFilter("neracaSaldo"),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var dataNeracaSaldo =
                      controller.getBukuBesarAllSaldoTotal()[index];
                  return NecaraSaldoItemCard(
                    data: dataNeracaSaldo,
                  );
                },
                itemCount: controller.getBukuBesarAllSaldoTotal().length,
              ),
            )
          ],
        ),
      ),
      bottomSheet: AspectRatio(
        aspectRatio: 16 / 2.5,
        child: Padding(
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
                  const Text(
                    'Debit',
                  ),
                  Text(
                    total["debit"].toString().currentcy,
                    style: AppTextStyle.body3
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Kredit'),
                  Text(
                    total["kredit"] != null
                        ? total["kredit"]!.abs().toString().currentcy
                        : "Rp0",
                    style: AppTextStyle.body3
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
