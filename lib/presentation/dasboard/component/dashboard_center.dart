import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/presentation/dasboard/controller/dashboard_controller.dart';
import 'package:intl/intl.dart';

class DashboardCenter extends GetView<DashboardController> {
  const DashboardCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
        child: Row(
          children: [
            const Icon(Icons.date_range_rounded),
            const SizedBox(
              width: 10,
            ),
            Text(DateFormat("dd MMMM yyyy").format(controller.selectedDate)),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now(),
                );

                if (date != null) {
                  controller.setSelectedDate = date;
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 206, 206, 206),
                          Colors.black
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: const Text(
                  "Ganti Tanggal",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
