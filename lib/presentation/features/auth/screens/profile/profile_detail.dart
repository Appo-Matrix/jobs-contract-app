import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/common_widgets/appbar2.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
// Import the profile text strings extension

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  String? selectedYear;
  final List<String> years = List.generate(
      30, (index) => (DateTime.now().year - index).toString());

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final backgroundColor = isDark ? JAppColors.darkGray800 : Colors.white;
    final textColor = isDark ? JAppColors.lightGray100 : JAppColors.darkGray800;
    final secondaryTextColor = isDark ? JAppColors.lightGray300 : JAppColors.darkGray500;
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
              children: [
                Text(
                  JText.profileDetails,
                  style: AppTextStyle.dmSans(
                    color: textColor,
                    fontSize: 28.0,
                    weight: FontWeight.w800,
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
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: cardColor,
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: isDark ? JAppColors.lightGray300 : JAppColors.darkGray300,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C38FF),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                          height: 48,
                          width: 48,
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
                            color: const Color(0xFF6C38FF),
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: JText.clickToUpload,
                                style: AppTextStyle.dmSans(
                                  color: const Color(0xFF6C38FF),
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
                Text(
                  JText.certificateOrLicenseName,
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
                        color: const Color(0xFF6C38FF),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Awarded By and Year
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            JText.awardedBy,
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
                                  color: const Color(0xFF6C38FF),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                          DropdownButtonFormField<String>(
                            value: selectedYear,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: textColor,
                            ),
                            dropdownColor: backgroundColor,
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
                                  color: const Color(0xFF6C38FF),
                                ),
                              ),
                            ),
                            items: years.map<DropdownMenuItem<String>>((String value) {
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
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),

                // Next Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to verification screen
                      AppRouter.router.push('/verificationScreen');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C38FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      JText.nextStepVerification,
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
}