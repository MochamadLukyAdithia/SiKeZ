import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/presentation/report/component/date_filter_from_controller.dart';
// import 'package:hmj_apps/presentation/report/component/item_card/neraca_double_item_card.dart';
// import 'package:hmj_apps/presentation/report/component/item_card/neraca_item_card.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_neraca_controller.dart';
// import 'package:hmj_apps/presentation/report/model/neraca_model.dart';

class NeracaListScreen extends GetView<ReportNeracaController> {
  const NeracaListScreen({super.key});

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
        title: const Text("Neraca"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          DateFilterFromController(controller: controller),
          Expanded(
            child: Obx(
              () {
                final data = controller.getReport();
                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        )
                      ],
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Aset",
                          style: AppTextStyle.body2.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(
                          data.hartaLancarList.length,
                          (index) => Row(
                            children: [
                              Expanded(
                                child: Text(
                                  data.hartaLancarList[index].name,
                                ),
                              ),
                              Text(
                                data.hartaLancarList[index].nominal >= 0
                                    ? data.hartaLancarList[index].nominal
                                        .toString()
                                        .currentcy
                                    : "(${data.hartaLancarList[index].nominal.abs().toString().currentcy})",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              "Total Aset",
                              style: AppTextStyle.body2.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Divider(
                                  color: AppColors.secondaryColor,
                                  thickness: 1.5,
                                ),
                              ),
                            ),
                            Text(
                              data.hartaLancarTotal >= 0
                                  ? data.hartaLancarTotal.toString().currentcy
                                  : "(${(data.hartaLancarTotal.abs().toString().currentcy)})",
                              style: AppTextStyle.body2.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Hutang",
                          style: AppTextStyle.body2.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(
                          data.hutangList.length,
                          (index) => Row(
                            children: [
                              Expanded(
                                child: Text(
                                  data.hutangList[index].name,
                                ),
                              ),
                              Text(
                                data.hutangList[index].nominal >= 0
                                    ? data.hutangList[index].nominal
                                        .toString()
                                        .currentcy
                                    : "(${data.hutangList[index].nominal.abs().toString().currentcy})",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Total Hutang",
                                style: AppTextStyle.body3.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              data.hutangTotal >= 0
                                  ? data.hutangTotal.toString().currentcy
                                  : "(${data.hutangTotal.abs().toString().currentcy})",
                              style: AppTextStyle.body3.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Modal",
                          style: AppTextStyle.body2.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(children: [
                          Expanded(
                            child: Text(
                              data.labaRugi >= 0
                                  ? "Laba Bersih"
                                  : "Rugi Bersih",
                            ),
                          ),
                          Text(
                            data.labaRugi >= 0
                                ? data.labaRugi.toString().currentcy
                                : "(${data.labaRugi.abs().toString().currentcy})",
                          ),
                        ]),
                        ...List.generate(
                          data.modalList.length,
                          (index) => Row(
                            children: [
                              Expanded(
                                child: Text(
                                  data.modalList[index].name,
                                ),
                              ),
                              Text(
                                data.modalList[index].nominal >= 0
                                    ? data.modalList[index].nominal
                                        .toString()
                                        .currentcy
                                    : "(${data.modalList[index].nominal.abs().toString().currentcy})",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Total Modal",
                                style: AppTextStyle.body3.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              data.modalTotal >= 0
                                  ? data.modalTotal.toString().currentcy
                                  : "(${data.modalTotal.abs().toString().currentcy})",
                              style: AppTextStyle.body3.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              "Total Hutang dan Modal",
                              style: AppTextStyle.body2.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Divider(
                                  color: AppColors.secondaryColor,
                                  thickness: 1.5,
                                ),
                              ),
                            ),
                            Text(
                              (data.modalTotal + data.hutangTotal) >= 0
                                  ? (data.modalTotal + data.hutangTotal)
                                      .toString()
                                      .currentcy
                                  : "(${(data.modalTotal + data.hutangTotal).abs().toString().currentcy})",
                              style: AppTextStyle.body2.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
