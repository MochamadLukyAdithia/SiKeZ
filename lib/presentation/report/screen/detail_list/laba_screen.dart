import 'package:flutter/material.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/component/date_filter.dart';

class LabaRugiListScreen extends StatelessWidget {
  const LabaRugiListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Laba Rugi"),
      ),
       body: Container(
        child: Column(
          children: [DateFilter()],
        ),
      ),
    );
  }
}
