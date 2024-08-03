import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/core/utils/icons.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Colors.white, Color.fromARGB(255, 224, 224, 224)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          SvgPicture.asset(AssetIcon.calendarIcon),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tanggal",
                style: AppTextStyle.body4,
              ),
              Text(
                "18 Feb 2025",
                style: AppTextStyle.body2.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            color: Colors.black26,
            height: 35,
            width: 2,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Waktu",
                style: AppTextStyle.body4,
              ),
              Text(
                "21:30",
                style: AppTextStyle.body2.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Spacer(),
          Icon(
            Icons.edit,
            color: AppColors.secondaryColor,
          )
        ],
      ),
    );
  }
}
