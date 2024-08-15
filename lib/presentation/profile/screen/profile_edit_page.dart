import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:get/get.dart";
import "package:hmj_apps/core/helper/form_validation.dart";
import "package:hmj_apps/core/theme/app_colors.dart";
import "package:hmj_apps/presentation/profile/controller/profile_controller.dart";
import "package:hmj_apps/presentation/profile/model/user_model.dart";
import "package:hmj_apps/presentation/shared/custom_button.dart";
import "package:hmj_apps/presentation/shared/custom_text_field.dart";

class ProfileEditPage extends GetView<ProfileController> {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor,
                Color(0xff464F37)
              ], // Add your colors here
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (controller.userProfileData.value == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            UserProfle profile = controller.userProfileData.value!;
            return Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.camera),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormBuilder(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          CustomTextWithTitle(
                            initial:
                                profile.name,
                            name: "nama",
                            validator: FormValidation.isNotNullAndRequired,
                            label: "Nama",
                            hintText: "Masukkan nama anda...",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextWithTitle(
                            initial:
                                profile.phone ,
                            name: "nomor",
                            validator: FormValidation.isNotNullAndRequired,
                            label: "Nomor HP",
                            hintText: "Masukkan Nomor Ponsel anda...",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextWithTitle(
                            initial: profile.joined
                                    .toString() ,
                            name: "tanggalLahir",
                            validator: FormValidation.isNotNullAndRequired,
                            label: "Tanggal Lahir",
                            hintText: "Masukkan tanggal lahir anda...",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextWithTitle(
                            initial:
                                profile.address ,
                            name: "alamat",
                            validator: FormValidation.isNotNullAndRequired,
                            label: "Alamat",
                            hintText: "Masukkan Alamat anda...",
                          ),
                        ],
                      ))
                ],
              ),
            );
          }
        }),
      ),
      bottomSheet: Container(
          margin: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height / 6 - 100,
          child: SiKePeLinearButton(
            title: "Simpan",
            onPressed: () {
              controller.updateProfileData();
            },
            linearGradient: const LinearGradient(
              colors: [AppColors.primaryColor, Color(0xff464F37)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          )),
    );
  }
}
