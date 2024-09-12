import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/helper/form_validation.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/shared/custom_button.dart';
import 'package:hmj_apps/presentation/shared/custom_text_field.dart';
import 'package:hmj_apps/presentation/transaction/component/date_picker.dart';
import 'package:hmj_apps/presentation/transaction/component/dropdown_button.dart';
import 'package:hmj_apps/presentation/transaction/component/take_image.dart';
import 'package:hmj_apps/presentation/transaction/controller/add_transaction_controller.dart';
import 'package:hmj_apps/presentation/transaction/image_preview/image_viewer.dart';

class AddTransactionScreen extends GetView<AddTransactionController> {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        title: const Text("Tambah Transaksi"),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: FormBuilder(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                const CustomDatePicker(),
                const SizedBox(height: 12),
                Obx(
                  () => DropDownButtonWithSearch(
                    enable: true,
                    onTap: () {
                      _showModalBottomSheetOption(
                        title: "Jenis Transaksi",
                        context: context,
                        onItemSelected: (index) {
                          controller.setSelectedTransactionType =
                              controller.transactionTypeList[index];
                        },
                        itemList: controller.transactionTypeList
                            .map((element) => element.name ?? '')
                            .toList(),
                      );
                    },
                    value: controller.selectedTransactionType?.name,
                    title: "Jenis Transaksi*",
                  ),
                ),
                const SizedBox(height: 12),
                Obx(
                  () {
                    final list = controller.getProperDebits();
                    return DropDownButtonWithSearch(
                      onTap: () {
                        if (list.length > 1) {
                          _showModalBottomSheetOption(
                              context: context,
                              itemList: list
                                  .map((element) =>
                                      "${element.code} ${element.name}")
                                  .toList(),
                              onItemSelected: (index) {
                                controller.setSelectedFirstAccounts =
                                    list[index];
                              },
                              title: "Debit");
                        }
                      },
                      enable: list.length > 1,
                      title: "Debit*",
                      value: controller.selectedFirstAccounts?.name,
                    );
                  },
                ),
                const SizedBox(height: 12),
                Obx(() {
                  final list = controller.getProperCredits();
                  return DropDownButtonWithSearch(
                    enable: list.length > 1,
                    onTap: () {
                      if (list.length > 1) {
                        _showModalBottomSheetOption(
                            context: context,
                            onItemSelected: (index) {
                              controller.setSelectedSecondAccounts =
                                  list[index];
                            },
                            itemList: list
                                .map((element) =>
                                    "${element.code} ${element.name}")
                                .toList(),
                            title: "Kredit");
                      }
                    },
                    title: "Kredit*",
                    value: controller.selectedSecondAccounts?.name,
                  );
                }),
                const SizedBox(height: 12),
                const CustomTextWithTitle(
                  name: "nominal",
                  validator: FormValidation.isNotNullAndRequired,
                  label: "Nominal*",
                  textInputType: TextInputType.number,
                  hintText: "Masukkan Nominal transaksi...",
                ),
                const SizedBox(height: 12),
                const CustomTextWithTitle(
                  name: "notes",
                  validator: FormValidation.isNotNullAndRequired,
                  label: "Catatan",
                  hintText: "Masukkan Catatan Anda...",
                ),
                const SizedBox(height: 12),
                const Text("Bukti"),
                Obx(
                  () => controller.selectedFile != null
                      ? GestureDetector(
                          onTap: () => Get.to(
                              ImageViewer(file: controller.selectedFile!)),
                          child: Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.only(bottom: 12, top: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: AppColors.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: FileImage(controller.selectedFile!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
                const SizedBox(
                  height: 4,
                ),
                TakeImageButton(
                  onImageCaptured: (xFile) {
                    if (xFile != null) {
                      controller.setSelectedFile = xFile;
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SiKePeLinearButton(
                title: "Simpan",
                onPressed: controller.save,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showModalBottomSheetOption({
    required BuildContext context,
    required Function(int index) onItemSelected,
    required List<String> itemList,
    required String title,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: FractionallySizedBox(
            heightFactor: 0.6,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 20),
                    child: Text(
                      title,
                      style: Get.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  ...List.generate(
                    itemList.length,
                    (index) => InkWell(
                      onTap: () {
                        onItemSelected(index);
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: AppColors.lightGrey,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            itemList[index],
                            style: Get.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
