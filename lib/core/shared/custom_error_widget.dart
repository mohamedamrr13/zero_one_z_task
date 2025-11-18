import 'package:flutter/material.dart';
import 'package:zero_one_z_task/core/shared/custom_text.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;
  final double? height;
  final IconData? icon;
  final Color? iconColor;
  final Color? buttonColor;

  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
    this.height,
    this.icon,
    this.iconColor,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 220,
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
              text: 'عذراً، حدث خطأ',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff2D3748),
            ),
            const SizedBox(height: 8),

            // Error Message
            CustomText(
              text: errorMessage,
              fontSize: 13,
              color: const Color(0xff718096),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            SizedBox(height: 20),
            // Retry Bu tton
            ElevatedButton.icon(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor ?? const Color(0xffD946A6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
              ),
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text(
                'إعادة المحاولة',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
