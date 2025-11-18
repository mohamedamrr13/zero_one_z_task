import 'package:flutter/material.dart';

import 'package:zero_one_z_task/core/theming/app_colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final Color? color;
  final LinearGradient? gradient;
  final double fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? height;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  const CustomText({
    super.key,
    required this.text,
    this.color = AppColors.black,
    this.fontWeight = FontWeight.normal,
    required this.fontSize,
    this.fontFamily,
    this.textAlign,
    this.height,
    this.maxLines = 2,
    this.textDirection,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        height: height ?? 1.4,
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: color,
        decorationStyle: TextDecorationStyle.solid,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
      maxLines: maxLines,
    );
  }
}
