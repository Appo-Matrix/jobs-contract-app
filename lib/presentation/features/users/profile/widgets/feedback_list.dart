// Feedback List Widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class FeedbackList extends StatelessWidget {
  final bool isDark;

  const FeedbackList({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray700 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FeedbackItem(
            title: 'Drywall Installers Specialist',
            description: 'id lacus, tincidunt libero, gravida ex dignissim, Vestibulum Sed faucibus in vitae',
            reviewerName: 'Caitlyn King',
            reviewerPosition: 'Head of Design, Layers',
            isDark: isDark,
          ),
          SizedBox(height: 24),
          FeedbackItem(
            title: 'Drywall Installers Specialist',
            description: 'id lacus, tincidunt libero, gravida ex dignissim, Vestibulum Sed faucibus in vitae',
            reviewerName: 'Amélie Laurent',
            reviewerPosition: 'Product Manager, Sisyphus',
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

// Feedback Item Widget
class FeedbackItem extends StatelessWidget {
  final String title;
  final String description;
  final String reviewerName;
  final String reviewerPosition;
  final bool isDark;

  const FeedbackItem({
    Key? key,
    required this.title,
    required this.description,
    required this.reviewerName,
    required this.reviewerPosition,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeSm,
            weight: FontWeight.bold,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
          ),
        ),
        SizedBox(height: 4),

        // 5 star rating
        Row(
          children: List.generate(
            5,
                (index) => Icon(
              Icons.star,
              color: Colors.amber,
              size: 16,
            ),
          ),
        ),
        SizedBox(height: 8),

        Text(
          description,
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeEaSm,
            weight: FontWeight.normal,
            color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
          ),
        ),
        SizedBox(height: 12),

        // Reviewer info
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/reviewer.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reviewerName,
                  style: AppTextStyle.dmSans(
                    fontSize: JSizes.fontSizeSm,
                    weight: FontWeight.bold,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  ),
                ),
                Text(
                  reviewerPosition,
                  style: AppTextStyle.dmSans(
                    fontSize: JSizes.fontSizeEaSm,
                    weight: FontWeight.normal,
                    color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}