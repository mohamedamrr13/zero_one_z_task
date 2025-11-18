import 'package:flutter/material.dart';
import 'package:zero_one_z_task/features/home/presentation/widgets/category_section.dart';
import 'package:zero_one_z_task/features/home/presentation/widgets/custom_appbar.dart';
import 'package:zero_one_z_task/features/home/presentation/widgets/investment_banner.dart';
import 'package:zero_one_z_task/features/home/presentation/widgets/product_listview.dart';
import 'package:zero_one_z_task/features/home/presentation/widgets/reminder_listview.dart';
import 'package:zero_one_z_task/features/home/presentation/widgets/service_listview.dart';
import 'package:zero_one_z_task/features/home/presentation/widgets/session_list_view.dart';
import 'package:zero_one_z_task/features/home/presentation/widgets/title_row.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(),
            InvestmentBanner(),
            TitleRow(title: 'الجلسة القادمة'),
            SessionListView(),
            CategorySection(),
            TitleRow(title: 'تذكيراتي'),
            ReminderListView(),
            TitleRow(title: 'خدمات جديدة'),
            SizedBox(height: 10),
            ServiceListView(),

            SizedBox(height: 20),

            TitleRow(title: 'افضل المنتجات'),
            SizedBox(height: 10),

            ProductListView(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
