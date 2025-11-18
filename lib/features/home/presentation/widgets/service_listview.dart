import 'package:flutter/material.dart';
import 'package:zero_one_z_task/features/home/presentation/widgets/service_item.dart';

class ServiceListView extends StatelessWidget {
  const ServiceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: SizedBox(
        height: 190,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            return ServiceItem();
          },
        ),
      ),
    );
  }
}
