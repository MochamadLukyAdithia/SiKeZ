import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/report_item.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan"),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
        child: const Column(
          children: [
            ReportItem(title: "Jurnal Umum", route: AppRoute.reporJurnaltList),
            SizedBox(
              height: 15,
            ),
            ReportItem(
                title: "Buku Besar", route: AppRoute.reportBukuBesarList),
            SizedBox(
              height: 15,
            ),
            ReportItem(
                title: "Neraca Saldo", route: AppRoute.reportNearacaSaldoList),
            SizedBox(
              height: 15,
            ),
            ReportItem(
              title: "Laba Rugi",
              route: AppRoute.reportLabaRugiList,
            ),
            SizedBox(
              height: 15,
            ),
            ReportItem(
                title: "Perubahan Modal", route: AppRoute.reportModalList),
            SizedBox(
              height: 15,
            ),
            ReportItem(
              title: "Neraca",
              route: AppRoute.reportNeracaList,
            )
          ],
        ),
      ),
    );
  }
}
