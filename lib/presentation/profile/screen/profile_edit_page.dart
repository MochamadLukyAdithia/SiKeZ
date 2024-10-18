// import "package:cached_network_image/cached_network_image.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:get/get.dart";
import "package:hmj_apps/core/helper/form_validation.dart";
import "package:hmj_apps/core/theme/app_colors.dart";
import "package:hmj_apps/presentation/auth/controller/auth_controller.dart";
import "package:hmj_apps/presentation/profile/controller/profile_controller.dart";
import "package:hmj_apps/presentation/shared/custom_button.dart";
import "package:hmj_apps/presentation/shared/custom_text_field.dart";

class ProfileEditPage extends GetView<ProfileController> {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController.find;
    final userModel = authController.currentUser;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        foregroundColor: Colors.white,
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: controller.selectedImage.value == null
                          ? NetworkImage(
                              userModel?.imageUrl != null &&
                                      userModel!.imageUrl!.isNotEmpty
                                  ? userModel.imageUrl!
                                  : "https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450.jpg",
                            )
                          : FileImage(controller.selectedImage.value!)
                              as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    controller.getImageFromGallery();
                  },
                  child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/sikepi.appspot.com/o/driver_images%2F1000839321.jpg?alt=media&token=ede86ac5-5596-4d25-88ce-ab00aa51f42c"),
                  // child: Container(
                  //   height: 100,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     image: DecorationImage(
                  //       image: controller.selectedImage.value == null
                  //           ? CachedNetworkImageProvider(
                  //               userModel?.imageUrl != null &&
                  //                       userModel!.imageUrl!.isNotEmpty
                  //                   ? userModel.imageUrl!
                  //                   : "https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450.jpg",
                  //             )
                  //           : FileImage(controller.selectedImage.value!)
                  //               as ImageProvider,
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FormBuilder(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      CustomTextWithTitle(
                        initial: userModel?.name,
                        name: "nama",
                        validator: FormValidation.isNotNullAndRequired,
                        label: "Nama",
                        hintText: "Masukkan nama anda...",
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextWithTitle(
                        initial: FirebaseAuth.instance.currentUser?.email,
                        name: "email",
                        validator: FormValidation.isNotNullAndRequired,
                        label: "Email",
                        enable: false,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextWithTitle(
                        initial: userModel?.phoneNumber,
                        name: "nomor",
                        validator: FormValidation.isNotNullAndRequired,
                        label: "Nomor HP",
                        hintText: "Masukkan Nomor Ponsel anda...",
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextWithTitle(
                        initial: userModel?.address,
                        name: "alamat",
                        validator: FormValidation.isNotNullAndRequired,
                        label: "Alamat",
                        hintText: "Masukkan Alamat anda...",
                      ),
                      const SizedBox(height: 48),
                      SiKePeLinearButton(
                        title: "Simpan",
                        onPressed: () => controller.updateProfileData(),
                        linearGradient: AppColors.quaternaryGradient,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
