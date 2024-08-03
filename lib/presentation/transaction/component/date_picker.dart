import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/core/utils/icons.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({super.key});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2025),
        );
        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate;
          });

          // Show time picker after date is selected
          final TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            setState(() {
              selectedTime = pickedTime;
            });
          }
        }
      },
      child: Container(
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
                const Text(
                  "Tanggal",
                  style: AppTextStyle.body4,
                ),
                Text(
                  DateFormat.yMMMd().format(
                      selectedDate != null ? selectedDate! : DateTime.now()),
                  style:
                      AppTextStyle.body2.copyWith(fontWeight: FontWeight.bold),
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
                const Text(
                  "Waktu",
                  style: AppTextStyle.body4,
                ),
                Text(
                  selectedTime != null
                      ? "${selectedTime!.hour}:${selectedTime!.minute}"
                      : DateFormat.Hm().format(DateTime.now()),
                  style:
                      AppTextStyle.body2.copyWith(fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
