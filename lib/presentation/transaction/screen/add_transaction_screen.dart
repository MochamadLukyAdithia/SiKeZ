import 'package:flutter/material.dart';
import 'package:hmj_apps/core/helper/form_validation.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/shared/custom_button.dart';
import 'package:hmj_apps/presentation/shared/custom_text_field.dart';
import 'package:hmj_apps/presentation/transaction/component/date_picker.dart';
import 'package:hmj_apps/presentation/transaction/component/dropdown_button.dart';
import 'package:hmj_apps/presentation/transaction/component/take_image.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Transaksi"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              CustomDatePicker(),
              const SizedBox(
                height: 15,
              ),
              DropDownButtonWithSearch(
                title: "Jenis Transaksi*",
              ),
              const SizedBox(
                height: 15,
              ),
              DropDownButtonWithSearch(
                title: "Simpan Ke*",
              ),
              const SizedBox(
                height: 15,
              ),
              DropDownButtonWithSearch(
                title: "Diterima*",
              ),
              const SizedBox(
                height: 15,
              ),
              const CustomTextWithTitle(
                name: "nominal",
                validator: FormValidation.isNotNullAndRequired,
                label: "Nominal",
                hintText: "Masukkan Nominal transaksi...",
              ),
              const SizedBox(
                height: 15,
              ),
              const CustomTextWithTitle(
                name: "catatan",
                validator: FormValidation.isNotNullAndRequired,
                label: "Catatan",
                hintText: "Masukkan Catatan Anda...",
              ),
              const SizedBox(
                height: 15,
              ),
              TakeImageButton()
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          height: 55,
          child: SiKePeLinearButton(title: "Simpan", onPressed: () {})),
    );
  }
}
