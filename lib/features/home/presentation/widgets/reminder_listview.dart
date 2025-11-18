import 'package:flutter/material.dart';
import 'package:zero_one_z_task/core/theming/app_colors.dart';
import 'package:zero_one_z_task/features/home/data/models/reminder_model.dart';
import 'package:zero_one_z_task/features/home/presentation/widgets/reminder_item.dart';

class ReminderListView extends StatelessWidget {
  const ReminderListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ReminderModel> reminders = [
      ReminderModel(
        title: "لا تنسي غسول الشعر",
        description: "باستخدام شيه هيفين قالي",
        date: "اليوم",
        frequency: "3 مرات",
        backgroundColor: Color(0xffE8F5E9),
      ),
      ReminderModel(
        title: "استخدم كريم uivi",
        description: "اضف الكريم علي الوجه لمده ساعه",
        date: "اليوم",
        frequency: "2:00 PM",
        backgroundColor: AppColors.white,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: SizedBox(
        height: 140,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: reminders.length,
          itemBuilder: (context, index) {
            return ReminderItem(reminder: reminders[index]);
          },
        ),
      ),
    );
  }
}
