import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
      decoration: InputDecoration(hintText: hintText),
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
          Text(name),
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
