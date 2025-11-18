import 'package:flutter/material.dart';
import 'package:zero_one_z_task/core/shared/custom_text.dart' show CustomText;
import 'package:zero_one_z_task/core/shared/gradient_text.dart';
import 'package:zero_one_z_task/core/theming/app_colors.dart';

class TitleRow extends StatelessWidget {
  const TitleRow({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
      child: Row(
        children: [
          CustomText(text: title, fontSize: 14, fontWeight: FontWeight.w600),
          Spacer(),
          Container(
            width: 67,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.3),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),

            child: Center(
              child: GradientText(
                'عرض الكل',
                gradient: AppColors.primaryGradient,
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
