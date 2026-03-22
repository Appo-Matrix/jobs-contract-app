import 'package:flutter/material.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final bool isDark;

  const ErrorStateWidget({
    super.key,
    required this.message,
    this.onRetry, required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline,
              color: Colors.red, size: 40),
          const SizedBox(height: 8),
          Text(
            message,
            style: AppTextStyle.dmSans(
              fontSize: 14.0,
              weight: FontWeight.w400,
              color: isDark
                  ? JAppColors.darkGray500
                  : Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 12),
            TextButton(
              onPressed: onRetry,
              child:  Text('Retry',            style: AppTextStyle.dmSans(
                fontSize: 14.0,
                weight: FontWeight.w400,
                color: isDark
                    ? JAppColors.darkGray500
                    : Colors.grey,
              ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}