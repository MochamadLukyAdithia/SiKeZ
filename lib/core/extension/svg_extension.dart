import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension SvgExtension on SvgPicture {
  SizedBox setSizeConstraint(double width, double height) =>
      SizedBox(width: width, height: height, child: this);
}
