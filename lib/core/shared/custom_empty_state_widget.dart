import 'package:flutter/material.dart';
import 'package:zero_one_z_task/core/shared/custom_text.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String? description;
  final IconData? icon;
  final double? height;
  final VoidCallback? onAction;
  final String? actionText;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.description,
    this.icon,
    this.height,
    this.onAction,
    this.actionText,
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
            // Empty Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon ?? Icons.inbox_outlined,
                size: 48,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 16),

            // Empty Message
            CustomText(
              text: message,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xff2D3748),
            ),

            if (description != null) ...[
              const SizedBox(height: 8),
              CustomText(
                text: description!,
                fontSize: 13,
                color: const Color(0xff718096),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],

            if (onAction != null && actionText != null) ...[
              const SizedBox(height: 20),
              TextButton(
                onPressed: onAction,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xffD946A6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                child: Text(
                  actionText!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
