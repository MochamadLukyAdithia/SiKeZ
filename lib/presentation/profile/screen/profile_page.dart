import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/utils/images.dart';
import 'package:hmj_apps/presentation/auth/controller/auth_controller.dart';
import 'package:hmj_apps/presentation/profile/component/text_icon.dart';
import 'package:hmj_apps/presentation/shared/custom_button.dart';

class ProfilePage extends GetView<AuthController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.2,
                    margin: const EdgeInsets.only(bottom: 50),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 129, 145, 100),
                          AppColors.primaryColor
                        ],
                        stops: [0.1, 1],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      image: DecorationImage(
                          image: AssetImage(Images.coffeBg), fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              controller.currentUser?.imageUrl != null &&
                                      controller
                                          .currentUser!.imageUrl!.isNotEmpty
                                  ? controller.currentUser!.imageUrl!
                                  : "https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450.jpg",
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: AppColors.primaryGradient,
                ),
                child: Column(
                  children: [
                    TextIcon(
                        icon: Icons.person,
                        dataText: controller.currentUser?.name ?? "-"),
                    const SizedBox(
                      height: 24,
                    ),
                    TextIcon(
                        icon: Icons.phone,
                        dataText: controller.currentUser?.phoneNumber ?? "-"),
                    const SizedBox(
                      height: 24,
                    ),
                    TextIcon(
                        icon: Icons.location_pin,
                        dataText: controller.currentUser?.address ?? "-"),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(20),
                  child: SiKePeLinearButton(
                    title: "Edit Profile",
                    onPressed: () {
                      Get.toNamed(AppRoute.editProfile);
                    },
                    linearGradient: AppColors.quaternaryGradient,
                  )),
              Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: SiKePeLinearButton(
                    title: "Log out",
                    onPressed: FirebaseAuth.instance.signOut,
                  ))
            ],
          );
        }),
      ),
    );
  }
}
