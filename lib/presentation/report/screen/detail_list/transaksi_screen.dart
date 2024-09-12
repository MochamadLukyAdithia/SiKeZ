import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/helper/format_currency.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/date_filter_from_controller.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_transaction_list_controller.dart';
import 'package:hmj_apps/presentation/shared/custom_empty_warning.dart';
import 'package:hmj_apps/resources/assets.gen.dart';
import 'package:intl/intl.dart';

class TransaksiListScreen extends GetView<ReportTransactionListController> {
  const TransaksiListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        foregroundColor: Colors.white,
        title: const Text("Transaksi"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          DateFilterFromController(
            controller: Get.find<ReportTransactionListController>(),
          ),
          Expanded(
            child: Obx(() {
              final dataList = controller.getReport();
              if (dataList.isEmpty) {
                return const EmptyWarning();
              }
              return ListView.separated(
                  padding: const EdgeInsets.all(16),
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
                      child: InkWell(
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
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 2,
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    gradient: AppColors.primaryGradient,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Assets.icons.transaction.svg(
                                    fit: BoxFit.fitWidth,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn)),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.borderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 2,
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
          ),
        ],
      ),
    );
  }
}
