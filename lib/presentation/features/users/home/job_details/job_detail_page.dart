



import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:job_contracts/utils/common_widgets/appbar.dart';
import 'package:job_contracts/utils/common_widgets/back_circle.dart';
import 'package:job_contracts/utils/common_widgets/dot_progress_indicator.dart';
import 'package:job_contracts/utils/common_widgets/main_button.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../widget/question_field.dart';

class JobDetailsPage extends StatefulWidget {
  const JobDetailsPage({super.key});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  final TextEditingController _coverLetterController = TextEditingController();
  bool _isLoading = false;

  void _handleSubmit() {
    setState(() {
      _isLoading = true;
    });

    showDotProgressDialog(
      context: context,
      message: JText.submittingMessage,
    );

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context); // Close the dialog

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(JText.successMessage),
            backgroundColor: Colors.green,
          ),
        );

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      }
    });
  }

  @override
  void dispose() {
    _coverLetterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          JText.pageTitle,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    JText.jobTitle,
                    style: AppTextStyle.dmSans(
                      color: isDark ? JAppColors.lightGray100 : JAppColors.lightGray900,
                      fontSize: 18.0,
                      weight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    JText.companyDetails,
                    style: AppTextStyle.dmSans(
                      color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray700,
                      fontSize: 14.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 24),




                  const SizedBox(height: 24),

                  // Cover Letter Section
                  Text(
                    JText.coverLetterTitle,
                    style: AppTextStyle.dmSans(
                      color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                      fontSize: 14.0,
                      weight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),

    Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                      color: isDark ? JAppColors.backGroundDarkCard : Colors.transparent,
                    ),
                    child: TextField(
                      controller: _coverLetterController,
                      maxLines: null,
                      style: AppTextStyle.dmSans(
                          color: isDark ? JAppColors.lightGray100 : JAppColors.lightGray800,
                          fontSize: 14.9,
                          weight: FontWeight.w400
                      ),
                      decoration: InputDecoration(
                        hintText: "Describe why you're a good fit for this role...",
                        hintStyle: TextStyle(
                          color: isDark ? Colors.grey[500] : Colors.grey[400],
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Additional Questions
                  Text(
                    JText.additionalQuestions,
                    style: AppTextStyle.dmSans(
                      color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                      fontSize: 14.0,
                      weight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  QuestionField(
                    question: JText.question1,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  QuestionField(
                    question: JText.question2,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Submit button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? JAppColors.backGroundDarkCard : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: MainButton(
              onTap: _isLoading ? null : _handleSubmit,
              btn_title: JText.submitButton,
              btn_radius: 10,
              btn_color: JAppColors.main,
              btn_boarder_color: const Color(0xff7030F1),
              title_color: Colors.white,
              text_fontweight: FontWeight.w600,
              image_value: false,
            ),
          ),

          // Bottom indicator

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

