import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class SiKePiTextField extends StatelessWidget {
  final String name;
  final String? Function(String?) validator;
  final String? hintText;
  const SiKePiTextField(
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
  final String label;
  final String? Function(String?) validator;
  final String? hintText;
  const CustomTextWithTitle({
    super.key,
    required this.name,
    required this.validator,
    this.hintText,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 8),
          child: Text(
            label,
            style:
                Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        SiKePiTextField(
          name: name,
          validator: validator,
          hintText: hintText,
        ),
      ],
    );
  }
}
