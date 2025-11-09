import 'package:easy_localization/easy_localization.dart';
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
    final double height = JDeviceUtils.getScreenHeight(context);

    return Scaffold(
      appBar: JAppbar(
        leadingIcon: Icon(Icons.arrow_back),
        leadingOnPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          // Scrollable content area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'coverLetterTitle',
                    style: AppTextStyle.onest(
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray900,
                      fontSize: 14.0,
                      weight: FontWeight.w500,
                    ),
                  ).tr(),
                  const SizedBox(height: 8),

                  Container(
                    height: height*0.7  ,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                      color: isDark
                          ? JAppColors.backGroundDarkCard.withValues(alpha: 0.4)
                          : Colors.transparent,
                    ),
                    child: TextField(
                      controller: _coverLetterController,
                      maxLines: null,
                      expands: true, // Add this
                      textAlignVertical: TextAlignVertical.top, // Add this
                      style: AppTextStyle.dmSans(
                          color: isDark
                              ? JAppColors.lightGray100
                              : JAppColors.lightGray800,
                          fontSize: 14.9,
                          weight: FontWeight.w400),
                      decoration: InputDecoration(
                        hintText: 'describeFitForRole'.tr(),
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
                ],
              ),
            ),
          ),

          // Fixed buttons at bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Cancel Button
                Expanded(
                  child: MainButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    btn_title: 'Cancel',
                    btn_radius: 6,
                    buttonType: MainButtonType.outlined,
                    btn_border_color: isDark ? JAppColors.lightGray100 : JAppColors.primary,
                    title_color: isDark ? JAppColors.lightGray100 : JAppColors.primary,
                    text_fontweight: FontWeight.w600,

                    image_value: false,
                  ),
                ),
                const SizedBox(width: 16),

                // Submit Button
                Expanded(
                  child: MainButton(
                    onTap: _isLoading ? null : _handleSubmit,
                    btn_title: 'Submit',
                    btn_radius: 6,
                    btn_color: JAppColors.main,
                    btn_border_color: const Color(0xff7030F1),
                    title_color: Colors.white,
                    text_fontweight: FontWeight.w600,
                    image_value: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
