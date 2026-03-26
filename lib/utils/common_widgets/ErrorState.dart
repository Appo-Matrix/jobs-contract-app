import 'package:flutter/material.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';

class ErrorState extends StatelessWidget {
  final VoidCallback onRetry;
  final bool isDark;
  const ErrorState({required this.onRetry, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off_outlined, size: 56,
              color: isDark ? JAppColors.darkGray400 : JAppColors.lightGray500),
          const SizedBox(height: 12),
          Text('Could not load profile.',
              style: AppTextStyle.dmSans(
                  fontSize: 15, weight: FontWeight.w500,
                  color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600)),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}