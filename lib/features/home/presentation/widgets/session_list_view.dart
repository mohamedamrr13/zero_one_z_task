import 'package:flutter/material.dart';
import 'package:zero_one_z_task/core/theming/app_colors.dart';
import 'package:zero_one_z_task/features/home/data/models/session_model.dart';
import 'package:zero_one_z_task/features/home/presentation/widgets/session_item.dart';

class SessionListView extends StatelessWidget {
  const SessionListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SessionModel> sessions = [
      SessionModel(
        title: "الجلسه الرابعه",
        description: "علاج تساقط الشعر جهاذ التبريد",
        date: "10 أكتوبر",
        time: "2:00 PM",
        backgroundColor: Color(0xffFFF3F7),
      ),
      SessionModel(
        title: "الجلسه الخامسه",
        description: "علاج البشرة بالليزر",
        date: "15 أكتوبر",
        time: "3:30 PM",
        backgroundColor: AppColors.white,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: SizedBox(
        height: 140,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sessions.length,
          itemBuilder: (context, index) {
            return SessionItem(session: sessions[index]);
          },
        ),
      ),
    );
  }
}
