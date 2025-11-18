import 'package:flutter/material.dart';
import 'package:zero_one_z_task/core/shared/custom_image_asset.dart';
import 'package:zero_one_z_task/core/shared/custom_text.dart';
import 'package:zero_one_z_task/core/shared/icon_container.dart';
import 'package:zero_one_z_task/core/theming/app_colors.dart';
import 'package:zero_one_z_task/features/home/data/models/reminder_model.dart';

class ReminderItem extends StatelessWidget {
  final ReminderModel reminder;

  const ReminderItem({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: SizedBox(
            width: 200,
            height: 95,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: reminder.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: reminder.title, fontSize: 14),
                        CustomText(
                          text: reminder.description,
                          fontSize: 12,
                          color: AppColors.sessionItemGreyColor,
                        ),
                        Row(
                          spacing: 5,
                          children: [
                            CustomImageAsset(
                              imagePath: 'assets/icons/clock_icon.svg',
                            ),
                            CustomText(text: reminder.date, fontSize: 11),
                            CustomText(text: '-', fontSize: 11),
                            CustomText(text: reminder.frequency, fontSize: 11),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconContainer(
                    iconPath: 'assets/icons/hair_icon.svg',
                    containerSize: 32,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
