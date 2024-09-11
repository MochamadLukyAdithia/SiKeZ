import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/date_filter.dart';
import 'package:hmj_apps/presentation/report/component/item_card/neraca_double_item_card.dart';
import 'package:hmj_apps/presentation/report/component/item_card/neraca_item_card.dart';
import 'package:hmj_apps/presentation/report/controller/report_neraca_controller.dart';
import 'package:hmj_apps/presentation/report/model/neraca_model.dart';

class NeracaListScreen extends GetView<ReportNeracaController> {
  const NeracaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        foregroundColor: Colors.white,
        title: const Text("Neraca"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          )
        ],
      ),
      body: Obx(() {
        RxList<Neraca> allDataNeraca = controller.getAllNeracaDataItem();
        print(allDataNeraca.length);
        return Container(
          child: Column(
            children: [
              // const DateFilter("neraca"),
              NeracaItemCard(
                dataItem:
                    allDataNeraca.where((item) => item.kode[0] == "1").toList(),
                totalAset: controller.allTotal?["kas"] ?? 0,
              ),
              NeracaDoubleItemCard(
                hutang:
                    allDataNeraca.where((item) => item.kode[0] == "2").toList(),
                modal:
                    allDataNeraca.where((item) => item.kode[0] == "3").toList(),
                totalHutang: controller.allTotal?["hutang"] ?? 0,
                totalModal: controller.allTotal?["modal"] ?? 0,
                totalAll: controller.allTotal?["all"] ?? 0,
              )
            ],
          ),
        );
      }),
    );
  }
}
