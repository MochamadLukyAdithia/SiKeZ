import 'package:flutter/material.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/report_item.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> reportItems = [
      {"title": "Transaksi", "route": AppRoute.reportTransaksiList},
      {"title": "Jurnal Umum", "route": AppRoute.reporJurnaltList},
      {"title": "Buku Besar", "route": AppRoute.reportBukuBesarList},
      {"title": "Neraca Saldo", "route": AppRoute.reportNearacaSaldoList},
      {"title": "Laba Rugi", "route": AppRoute.reportLabaRugiList},
      {"title": "Perubahan Modal", "route": AppRoute.reportModalList},
      {"title": "Neraca", "route": AppRoute.reportNeracaList},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemBuilder: (context, index) => ReportItem(
          title: reportItems[index]['title'] ?? '',
          route: reportItems[index]['route'] ?? '',
        ),
        itemCount: reportItems.length,
      ),
    );
  }
}
