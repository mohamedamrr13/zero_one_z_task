import 'package:flutter/material.dart';
import 'package:zero_one_z_task/core/shared/custom_image_asset.dart';
import 'package:zero_one_z_task/core/shared/custom_text.dart';
import 'package:zero_one_z_task/core/shared/icon_container.dart';
import 'package:zero_one_z_task/core/theming/app_colors.dart';
import 'package:zero_one_z_task/features/home/data/models/session_model.dart';

class SessionItem extends StatelessWidget {
  final SessionModel session;

  const SessionItem({super.key, required this.session});

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
                    color: session.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: session.title, fontSize: 14),
                        CustomText(
                          text: session.description,
                          fontSize: 12,
                          color: AppColors.sessionItemGreyColor,
                        ),
                        Row(
                          spacing: 5,
                          children: [
                            CustomImageAsset(
                              imagePath: 'assets/icons/clock_icon.svg',
                            ),
                            CustomText(text: session.date, fontSize: 11),
                            CustomImageAsset(
                              imagePath: 'assets/icons/clock_icon.svg',
                            ),
                            CustomText(text: session.time, fontSize: 11),
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
                    iconPath: 'assets/icons/solar_bell_icon.svg',
                    containerSize: 27,
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
