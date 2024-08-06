import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/model/user_model.dart';
import 'package:hmj_apps/presentation/auth/controller/auth_controller.dart';
import 'package:hmj_apps/presentation/dasboard/component/dasboard_body.dart';
import 'package:hmj_apps/presentation/dasboard/component/dasboard_header.dart';
import 'package:hmj_apps/presentation/dasboard/component/dashboard_center.dart';

class DashboardSceen extends StatelessWidget {
  const DashboardSceen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController.find;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: const Column(
            children: [
              DasboardHeader(),
              DashboardCenter(),
              DashboardBody(),
            ],
          ),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                  colors: [Color(0xffA1B57D), Color(0xff464F37)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () async {
              AuthController.find.getUser();
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
