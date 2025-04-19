import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/portfilo_screen/widgets/upload_header.dart';
import 'package:job_contracts/presentation/features/auth/screens/portfilo_screen/widgets/upload_portfolio_screen.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/common_widgets/appbar2.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/sizes.dart';

class UploadPortfolioScreen extends StatefulWidget {
  const UploadPortfolioScreen({super.key});

  @override
  State<UploadPortfolioScreen> createState() => _UploadPortfolioScreenState();
}

class _UploadPortfolioScreenState extends State<UploadPortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final backgroundColor = isDark ? JAppColors.darkGray900 : Colors.white;
    final textColor = isDark ? JAppColors.lightGray100 : JAppColors.darkGray800;
    final secondaryTextColor =
        isDark ? JAppColors.lightGray300 : JAppColors.darkGray500;

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
                UploadHeader(textColor: textColor),

                // Before Upload Section
                Text(
                  JText.before,
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 16.0,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                UploadContainerWidget(
                  isDark: isDark,
                  cardColor: isDark ? JAppColors.darkGray800 : Colors.white,
                  accentColor: JAppColors.primary,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {
                    // Handle before image upload
                    print('Upload before image');
                  },
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
                UploadContainerWidget(
                  isDark: isDark,
                  cardColor: isDark ? JAppColors.darkGray800 : Colors.white,
                  accentColor: JAppColors.primary,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {
                    // Handle after image upload
                    print('Upload after image');
                  },
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
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Enter a description...",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                TextFieldWidget(
                  keyboardType: TextInputType.number,

                  subTitle: JText.estimatedServiceCost,
                  hintText: JText.estimatedServiceCost,
                  subtitleColor:
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  titleColor:
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                ),

                const SizedBox(height: 24),


                TextFieldWidget(
                  subTitle:  JText.estimatedCompletionTime,
                  hintText:  JText.estimatedCompletionTime,
                  subtitleColor:
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  titleColor:
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 32),
                MainButton(
                    btn_title: JText.uploadPortfolio,
                    btn_radius: 10,
                    btn_color: JAppColors.main,
                    btn_boarder_color: Color(0xff7030F1),
                    title_color: Colors.white,
                    text_fontweight: FontWeight.w600,
                    image_value: false,
                    onTap: () {
                      AppRouter.router.push('/specializationScreen');
                    }),

                MainButton(
                  btn_title: JText.skip,
                  btn_radius: 10,
                  btn_color: Colors.transparent,
                  btn_boarder_color: Colors.transparent,
                  title_color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  text_fontweight: FontWeight.w600,
                  image_value: false,
                  onTap: () {},
                  text_size: JSizes.fontSizeMd,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
