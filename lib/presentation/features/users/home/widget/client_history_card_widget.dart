import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';


class ClientHistoryCardWidget extends StatelessWidget {
  final bool isDark;
  final String companyName;
  final double minBudget;
  final double maxBudget;
  final String description;
  final String clientName;
  final String clientImage;
  final int rating;

  const ClientHistoryCardWidget({
    super.key,
    required this.isDark,
    required this.companyName,
    required this.minBudget,
    required this.maxBudget,
    required this.description,
    required this.clientName,
    this.clientImage = JImages.image,
    this.rating = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray700 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company Name
          Text(
            companyName,
            style: AppTextStyle.onest(
              fontSize: 14.0,
              weight: FontWeight.w600,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            ),
          ),

          const SizedBox(height: 8),

          // Star Rating
          Row(
            children: List.generate(
              rating,
                  (index) => const Icon(
                Icons.star,
                size: 16,
                color: Colors.amber,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Budget
          Text(
            "\$${minBudget.toStringAsFixed(0)} - \$${maxBudget.toStringAsFixed(0)}",
            style: AppTextStyle.onest(
              fontSize: 14.0,
              weight: FontWeight.w600,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            ),
          ),

          const SizedBox(height: 8),

          // Description
          Text(
            description,
            style: AppTextStyle.onest(
              fontSize: 12.0,
              height: 1.5,
              weight: FontWeight.w400,
              color: isDark ? JAppColors.lightGray300 : JAppColors.lightGray600,
            ),
          ),

          const SizedBox(height: 12),

          // Client Info
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(clientImage),
              ),
              const SizedBox(width: 8),
              Text(
                clientName,
                style: AppTextStyle.onest(
                  fontSize: 12.0,
                  weight: FontWeight.w500,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
