import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/utils/images.dart';
import 'package:hmj_apps/presentation/dasboard/controller/dashboard_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_laba_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_neraca_controller.dart';

class DasboardHeader extends GetView<DashboardController> {
  const DasboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportLabaController reportLabaController =
        Get.find<ReportLabaController>();

    Map<String, dynamic> getResult() {
      var lastMonthResult =
          reportLabaController.getLastMonthReport().cleanResult;
      var thisMonthResult =
          reportLabaController.getThisMonthReport().cleanResult;

      final result = (thisMonthResult - lastMonthResult) / lastMonthResult;
      final text =
          "${result == 0 ? 'Sama dengan' : result > 0 ? '${(result * 100).toStringAsFixed(0)}% lebih banyak dari' : '${(result.abs() * 100).toStringAsFixed(0)}% lebih sedikit dari'} bulan sebelumnya";

      final color = result >= 0 ? Colors.amber : Colors.grey;

      return {
        "text": lastMonthResult == 0 || thisMonthResult == 0 ? null : text,
        "color": color,
      };
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xff19282F),
          Color(0xffB33030),
          Color.fromARGB(255, 210, 57, 57)
        ], stops: [
          0.01,
          0.5,
          0.9
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Total aset anda:",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                Get.find<ReportNeracaController>()
                    .getAssetTotal()
                    .toString()
                    .currentcy,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: Colors.white,
              ),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Laba Rugi bulan ini:",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        reportLabaController
                            .getThisMonthReport()
                            .cleanResult
                            .toString()
                            .currentcy,
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Builder(builder: (context) {
                        final result = getResult();
                        if (result['text'] != null) {
                          return Text(
                            getResult()['text'],
                            style: TextStyle(
                              fontSize: 12,
                              color: getResult()['color'],
                            ),
                          );
                        }
                        return const SizedBox();
                      }),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(Images.iconBullish)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
