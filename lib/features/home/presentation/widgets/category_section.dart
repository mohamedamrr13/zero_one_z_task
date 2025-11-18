import 'package:flutter/material.dart';
import 'package:zero_one_z_task/features/home/presentation/widgets/category_item.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: Row(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CategoryItem(
              text: 'الخدمات',
              imagePath: 'assets/images/services_image.png',
              color: Color(0xffFDF1D6),
            ),
            CategoryItem(
              text: 'المنتجات',
              imagePath: 'assets/images/product_image.png',
              color: Color(0xffE2EBFE),
            ),
          ],
        ),
      ),
    );
  }
}
