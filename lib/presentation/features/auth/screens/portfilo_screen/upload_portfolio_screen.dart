import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/common_widgets/appbar2.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/device/device_utility.dart';


class UploadPortfolioScreen extends StatefulWidget {
  const UploadPortfolioScreen({super.key});

  @override
  State<UploadPortfolioScreen> createState() => _UploadPortfolioScreenState();
}

class _UploadPortfolioScreenState extends State<UploadPortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final backgroundColor = isDark ? JAppColors.darkGray800 : Colors.white;
    final textColor = isDark ? JAppColors.lightGray100 : JAppColors.darkGray800;
    final secondaryTextColor = isDark ? JAppColors.lightGray300 : JAppColors.darkGray500;
    final cardColor = isDark ? JAppColors.darkGray700 : const Color(0xFFF1F2F6);
    final purpleColor = const Color(0xFF6C38FF);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: JAppBar2(title: JText.back),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  JText.uploadPortfolio,
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 28.0,
                    weight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  JText.choosePreferredOption,
                  style: AppTextStyle.dmSans(
                    color: secondaryTextColor,
                    fontSize: 16.0,
                    weight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 32),

                // Upload Portfolios Section
                Text(
                  JText.uploadPortfolios,
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 20.0,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),

                // Before Upload Section
                Text(
                  JText.before,
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 16.0,
                    weight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _buildUploadContainer(
                  context,
                  isDark: isDark,
                  cardColor: cardColor,
                  purpleColor: purpleColor,
                  secondaryTextColor: secondaryTextColor,
                ),
                const SizedBox(height: 24),

                // After Upload Section
                Text(
                  JText.after,
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 16.0,
                    weight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _buildUploadContainer(
                  context,
                  isDark: isDark,
                  cardColor: cardColor,
                  purpleColor: purpleColor,
                  secondaryTextColor: secondaryTextColor,
                ),
                const SizedBox(height: 24),

                // Brief Description
                Text(
                  JText.briefDescription,
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 16.0,
                    weight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
                    ),
                  ),
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16),
                      border: InputBorder.none,
                      hintText: 'Enter description here...',
                      hintStyle: AppTextStyle.dmSans(
                        color: secondaryTextColor,
                        fontSize: 14.0,
                        weight: FontWeight.w400,
                      ),
                    ),
                    style: AppTextStyle.dmSans(
                      color: textColor,
                      fontSize: 16.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Estimated Service Cost
                Text(
                  JText.estimatedServiceCost,
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 16.0,
                    weight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: purpleColor,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: secondaryTextColor,
                    ),
                    hintText: 'Enter amount',
                    hintStyle: AppTextStyle.dmSans(
                      color: secondaryTextColor,
                      fontSize: 14.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 16.0,
                    weight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 24),

                // Estimated Completion Time
                Text(
                  JText.estimatedCompletionTime,
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 16.0,
                    weight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: purpleColor,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.access_time,
                      color: secondaryTextColor,
                    ),
                    hintText: 'e.g., 2 weeks',
                    hintStyle: AppTextStyle.dmSans(
                      color: secondaryTextColor,
                      fontSize: 14.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 16.0,
                    weight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 32),

                // Upload Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to next screen
                      AppRouter.router.push('/nextScreen');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purpleColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      JText.uploadPortfolio,
                      style: AppTextStyle.dmSans(
                        color: Colors.white,
                        fontSize: 16.0,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadContainer(
      BuildContext context, {
        required bool isDark,
        required Color cardColor,
        required Color purpleColor,
        required Color secondaryTextColor,
      }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.file_upload_outlined,
                color: purpleColor,
                size: 18,
              ),
            ),
            const SizedBox(height: 6),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: JText.clickToUpload,
                    style: AppTextStyle.dmSans(
                      color: purpleColor,
                      fontSize: 14.0,
                      weight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: JText.orDragAndDrop,
                    style: AppTextStyle.dmSans(
                      color: secondaryTextColor,
                      fontSize: 14.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              JText.fileFormats,
              style: AppTextStyle.dmSans(
                color: secondaryTextColor,
                fontSize: 12.0,
                weight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}