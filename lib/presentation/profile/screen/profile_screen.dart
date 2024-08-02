import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hmj_apps/core/helper/form_validation.dart';
import 'package:hmj_apps/presentation/transaction/component/dropdown_button.dart';
import 'package:hmj_apps/presentation/shared/custom_button.dart';
import 'package:hmj_apps/presentation/shared/custom_text_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FormBuilder(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                // Container(
                //   height: 50,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15),
                //     border: Border.all(color: Colors.black26),
                //   ),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       const SizedBox(
                //         width: 10,
                //       ),
                //       Text("text"),
                //     ],
                //   ),
                // ),
                DropDownButtonWithSearch(),

                const CustomTextWithTitle(
                  name: "email",
                  validator: FormValidation.isNotNullAndRequired,
                  label: "Email",
                  hintText: "Masukkan email anda...",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
