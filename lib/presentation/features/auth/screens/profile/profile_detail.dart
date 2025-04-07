import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/common_widgets/appbar2.dart';
import 'package:job_contracts/utils/common_widgets/text_field_widget.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import 'package:job_contracts/utils/constants/image_string.dart';

import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/sizes.dart';
// Import the profile text strings extension

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  String? selectedYear;
  final List<String> years =
      List.generate(30, (index) => (DateTime.now().year - index).toString());

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final backgroundColor = isDark ? JAppColors.darkGray900 : Colors.white;
    final textColor = isDark ? JAppColors.lightGray100 : JAppColors.darkGray800;
    final secondaryTextColor =
        isDark ? JAppColors.lightGray300 : JAppColors.darkGray500;
    final cardColor = isDark ? JAppColors.darkGray700 : const Color(0xFFF1F2F6);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: JAppBar2(title: JText.back),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  JText.profileDetails,
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 24.0,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 32),

                // Profile Photo Section
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: JText.profilePhoto,
                        style: AppTextStyle.dmSans(
                          color: textColor,
                          fontSize: 20.0,
                          weight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '*',
                        style: AppTextStyle.dmSans(
                          color: Colors.red,
                          fontSize: 20.0,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Stack(
                  children: [
                    Positioned.fill(
                      child: CircleAvatar(
                        backgroundColor: isDark
                            ? JAppColors.darkGray700
                            : const Color(0xFFF1F2F6),
                      ),
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C38FF),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Resume Upload Section
                Text(
                  JText.uploadResume,
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 20.0,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? JAppColors.darkGray600
                          : JAppColors.lightGray300,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.white,
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
                            color: JAppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: JText.clickToUpload,
                                style: AppTextStyle.dmSans(
                                  color: JAppColors.primary,
                                  fontSize: 16.0,
                                  weight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: JText.orDragAndDrop,
                                style: AppTextStyle.dmSans(
                                  color: secondaryTextColor,
                                  fontSize: 16.0,
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
                            fontSize: 14.0,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Certificates Section
                Text(
                  JText.certificatesAndLicenses,
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 20.0,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 8),

                TextFieldWidget(
                  subTitle: JText.certificateOrLicenseName,
                  subtitleColor:
                  isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                  titleColor:
                  isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                ),
                const SizedBox(height: 16),

                // Awarded By and Year
                Row(
                  children: [
                    Expanded(
                      child:    TextFieldWidget(
                        subTitle:JText.awardedBy ,
                        subtitleColor:
                        isDark ? JAppColors.lightGray100 : JAppColors.grayBlue800,
                        titleColor:
                        isDark ? Colors.white : JAppColors.grayBlue800,
                      ),
                      // child: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //
                      //     const SizedBox(height: 8),
                      //
                      //   ],
                      // ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            JText.year,
                            style: AppTextStyle.dmSans(
                              color: textColor,
                              fontSize: 16.0,
                              weight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 50,
                            child: DropdownButtonFormField<String>(
                              value: selectedYear,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: textColor,
                              ),



                              dropdownColor: backgroundColor,
                              isExpanded: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: isDark ? JAppColors.darkGray800 : Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: isDark ? JAppColors.darkGray800 : Colors.white,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    width: 1.5,
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF6C38FF),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                              ),
                              items: years
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: AppTextStyle.dmSans(
                                      color: textColor,
                                      fontSize: 16.0,
                                      weight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedYear = newValue;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    )                  ],
                ),
                const SizedBox(height: 48),

                MainButton(
                  onTap: () {
                    AppRouter.router.push('/uploadPortfolioScreen');
                  },
                  btn_title: JText.signUp,
                  btn_radius: 10,
                  btn_color: JAppColors.main,
                  btn_boarder_color: Color(0xff7030F1),
                  title_color: Colors.white,
                  text_fontweight: FontWeight.w600,
                  image_value: false,
                ),

                // Next Button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
