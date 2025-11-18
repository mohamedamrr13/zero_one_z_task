import 'package:flutter/material.dart';
import 'package:zero_one_z_task/core/shared/custom_text.dart';
import 'package:zero_one_z_task/core/theming/app_colors.dart';
import 'package:zero_one_z_task/core/shared/icon_container.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.5, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconContainer(iconPath: 'assets/icons/qr_icon.svg', iconSize: 27),
          SizedBox(width: 9),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 3,
            children: [
              CustomText(text: 'مرحبا بك مريم احمد', fontSize: 16),
              CustomText(
                text: 'كيف حالك اليوم',
                fontSize: 12,
                color: AppColors.appBarSecondaryTextColor,
              ),
            ],
          ),
          Spacer(),
          IconContainer(iconPath: 'assets/icons/notification_icon.svg'),
          SizedBox(width: 16),
          IconContainer(iconPath: 'assets/icons/cart_icon.svg'),
        ],
      ),
    );
  }
}
