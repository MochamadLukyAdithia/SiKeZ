import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/utils/images.dart';
import 'package:hmj_apps/presentation/profile/component/text_icon.dart';
import 'package:hmj_apps/presentation/profile/controller/profile_controller.dart';
import 'package:hmj_apps/presentation/profile/model/user_model.dart';
import 'package:hmj_apps/presentation/shared/custom_button.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(() {
          UserProfle? profile = controller.userProfileData.value;
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4 + 20,
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 5,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 129, 145, 100),
                                  AppColors.primaryColor
                                ],
                                stops: [
                                  0.01,
                                  // 0.5,
                                  0.6
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            image: DecorationImage(
                                image: AssetImage(Images.coffeBg),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: MediaQuery.of(context).size.height / 6 - 40,
                      child: AspectRatio(
                        aspectRatio: 16 / 4,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(profile?.imageUrl ?? ""),
                          // child: Container(
                          //   child: Image.asset(Images.logoPpk),
                          // ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
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
                    TextIcon(icon: Icons.person, dataText: profile?.name ?? ""),
                    const SizedBox(
                      height: 30,
                    ),
                    TextIcon(icon: Icons.phone, dataText: profile?.phone ?? ""),
                    const SizedBox(
                      height: 30,
                    ),
                    // TextIcon(
                    //     icon: Icons.calendar_month, dataText: profile.joined),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    TextIcon(
                        icon: Icons.location_pin,
                        dataText: profile?.address ?? ""),
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
                    linearGradient: const LinearGradient(
                        colors: [Color(0xffA1B57D), Color(0xff464F37)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
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
