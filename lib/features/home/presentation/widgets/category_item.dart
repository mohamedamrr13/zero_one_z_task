import 'package:flutter/material.dart';
import 'package:zero_one_z_task/core/shared/custom_image_asset.dart';
import 'package:zero_one_z_task/core/shared/custom_text.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.text,
    required this.imagePath,
    required this.color,
  });
  final String text;
  final String imagePath;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),

        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: text, fontSize: 17),
            Spacer(),
            CustomImageAsset(imagePath: imagePath),
          ],
        ),
      ),
    );
  }
}
