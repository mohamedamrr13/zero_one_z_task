import 'package:flutter/material.dart';
import 'package:zero_one_z_task/core/theming/app_colors.dart';

class InvestmentBanner extends StatelessWidget {
  const InvestmentBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 180,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 140,
            top: 40,
            bottom: 0,
            child: Image.asset(
              'assets/images/banner_image.png',
              height: 180,
              fit: BoxFit.contain,
            ),
          ),

          // Text content on the right side (RTL)
          Positioned(
            left: 20,
            top: 0,
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'استثمر في جمالك معانا',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'احصل على نقاط عند شراء المنتجات او\nاستخدام الخدمات',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.95),
                      fontSize: 14,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
