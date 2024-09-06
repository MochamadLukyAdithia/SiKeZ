import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/helper/format_currency.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/dasboard/controller/dashboard_controller.dart';
import 'package:hmj_apps/resources/assets.gen.dart';
import 'package:intl/intl.dart';

class DashboardBody extends GetView<DashboardController> {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Transaksi",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Obx(() {
            final dataList = controller.getTransactionList;
            if (dataList.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    Assets.icons.transactionMinusSvgrepoCom.svg(
                      width: Get.width * 0.3,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Tidak ada transaksi.",
                      textAlign: TextAlign.center,
                      style: Get.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Silahkan tambahkan transaksi baru atau pilih tanggal lain.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 12),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.red,
                      ),
                      padding: const EdgeInsets.only(right: 24),
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.delete_forever_rounded,
                        color: Colors.white,
                      ),
                    ),
                    key: ValueKey(dataList[index].date.toIso8601String()),
                    onDismissed: (_) => controller.removeTransaction(index),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Get.toNamed(AppRoute.reportTransaksiDetail,
                            arguments: dataList[index]);
                      },
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Container(
                              height: double.infinity,
                              width: 48,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Assets.icons.transaction.svg(
                                fit: BoxFit.fitWidth,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black26),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            dataList[index].transactionName,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          DateFormat('dd MMMM yyyy')
                                              .format(dataList[index].date),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                        "${dataList[index].debitName} -> ${dataList[index].creditName}",
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      formatCurrency(dataList[index].nominal),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 12,
                  );
                },
                itemCount: dataList.length);
          }),
        ],
      ),
    );
  }
}
