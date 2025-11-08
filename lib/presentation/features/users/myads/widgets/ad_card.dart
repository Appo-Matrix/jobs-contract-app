
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../routes/app_routes.dart';
import '../model/ad.dart';

class AdCard extends StatelessWidget {
  final Ad ad;
  final VoidCallback onViewDetails;
  final VoidCallback onEditAd;
  final bool isDark;

  const AdCard({
    super.key,
    required this.ad,
    required this.onViewDetails,
    required this.onEditAd, required this.isDark,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ad Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              ad.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Ad Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  ad.title,
                  style: AppTextStyle.dmSans(
                    fontSize: 16.0,
                    weight: FontWeight.w500,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  ),
                ),

                const SizedBox(height: 12),

                // Price and Category
                Row(
                  children: [
                    // Price
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            JText.price,
                            style: AppTextStyle.dmSans(
                              fontSize: 16.0,
                              weight: FontWeight.w500,
                              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${JText.currencySymbol}${ad.price.toInt()}',
                            style: AppTextStyle.dmSans(
                              fontSize: 16.0,
                              weight: FontWeight.w500,
                              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Category
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            JText.category,
                            style: AppTextStyle.dmSans(
                              fontSize: 16.0,
                              weight: FontWeight.w500,
                              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            ad.category,
                            style: AppTextStyle.dmSans(
                              fontSize: 16.0,
                              weight: FontWeight.w500,
                              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: MainButton(
                        btn_title: 'viewDetails',
                        btn_radius: 10,
                        btn_color: JAppColors.main,
                        btn_border_color: Color(0xff7030F1),
                        title_color: Colors.white,
                        text_fontweight: FontWeight.w600,
                        image_value: false,
                        onTap: () {
                          AppRouter.router.push('/adDetailsScreen');
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MainButton(
                        btn_title: 'editAd',
                        btn_radius: 10,
                        btn_color: Colors.transparent,
                        btn_border_color: JAppColors.t,
                        title_color: isDark
                            ? JAppColors.darkGray100
                            : JAppColors.lightGray800,
                        text_fontweight: FontWeight.w600,
                        image_value: false,
                        onTap: () {},
                        text_size: JSizes.fontSizeMd,
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}