import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final String? Function(String?) validator;
  final String? hintText;
  const CustomTextField(
      {super.key, required this.name, required this.validator, this.hintText});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      validator: validator,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      style: const TextStyle(height: 1.0),
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class CustomTextWithTitle extends StatelessWidget {
  final String name;
  final String? Function(String?) validator;
  final String? hintText;
  const CustomTextWithTitle(
      {super.key, required this.name, required this.validator, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, bottom: 10, top: 10),
            child: Text(
              name,
              style: AppTextStyle.body2.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          CustomTextField(
            name: name,
            validator: validator,
            hintText: hintText,
          )
        ],
      ),
    );
  }
}
