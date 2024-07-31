import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hmj_apps/core/utils/images.dart';
import 'package:hmj_apps/presentation/dasboard/component/dasboard_body.dart';
import 'package:hmj_apps/presentation/dasboard/component/dasboard_header.dart';
import 'package:hmj_apps/presentation/dasboard/component/dashboard_center.dart';

class DashboardSceen extends StatelessWidget {
  const DashboardSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              const DasboardHeader(),
              const DashboardCenter(),
              const DashboardBody()
            ],
          ),
        ),
      ),
    );
  }
}
