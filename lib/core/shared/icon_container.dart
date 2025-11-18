import 'package:flutter/material.dart';
import 'package:zero_one_z_task/core/shared/custom_image_asset.dart';
import 'package:zero_one_z_task/core/theming/app_colors.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required this.iconPath,
    this.iconSize = 22,
    this.containerSize = 47,
  });
  final String iconPath;
  final double iconSize;
  final double containerSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerSize,
      width: containerSize,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: CustomImageAsset(
        imagePath: iconPath,
        width: iconSize,
        height: iconSize,
      ),
    );
  }
}
