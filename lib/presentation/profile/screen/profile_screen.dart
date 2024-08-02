import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/utils/images.dart';
import 'package:hmj_apps/presentation/profile/component/text_icon.dart';
import 'package:hmj_apps/presentation/shared/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4 + 20,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 4 - 30,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          image: DecorationImage(
                              image: AssetImage(Images.coffeBg),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 120,
                      child: SizedBox(
                        height: 120,
                        child: Container(
                          child: Image.asset(Images.logoPpk),
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
                    TextIcon(icon: Icons.person, dataText: "Nama User"),
                    const SizedBox(
                      height: 30,
                    ),
                    TextIcon(icon: Icons.phone, dataText: "081234124893"),
                    const SizedBox(
                      height: 30,
                    ),
                    TextIcon(
                        icon: Icons.calendar_month, dataText: "3 feb 2024"),
                    const SizedBox(
                      height: 30,
                    ),
                    TextIcon(
                        icon: Icons.location_pin,
                        dataText: "Jl. jalanisaja no 666,kota yang hilang"),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(20),
                  child: SiKePeLinearButton(
                    title: "Edit Profile",
                    onPressed: () {},
                    linearGradient: LinearGradient(
                        colors: [Color(0xffA1B57D), Color(0xff464F37)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  )),
              Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: SiKePeLinearButton(
                    title: "Log out",
                    onPressed: () {},
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
