import 'package:flutter/material.dart';
import 'package:job_contracts/utils/common_widgets/bottom_indicator.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/dot_progress_indicator.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

class ReportJobScreen extends StatefulWidget {
  const ReportJobScreen({super.key});

  @override
  State<ReportJobScreen> createState() => _ReportJobScreenState();
}

class _ReportJobScreenState extends State<ReportJobScreen> {
  String? selectedReason;
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = JDeviceUtils.getScreenWidth(context);

    final isDark = JDeviceUtils.isDarkMode(context);
    bool _isLoading = false;

    void _handleSubmit() {
      setState(() {
        _isLoading = true;
      });

      showDotProgressDialog(
        context: context,
        message: "Submitting report...",
      );

      // Simulate API call or processing
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context); // Close the dialog

        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          // Add your actual submission logic here
        }
      });
    }    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          JText.reportJob,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: JSizes.spaceBtwSections - 19,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      JText.selectReason,
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.darkGray100
                            : JAppColors.lightGray800,
                        fontSize: 16.0,
                        weight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      JText.selectReasonDescription,
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.darkGray300
                            : JAppColors.lightGray700,
                        fontSize: 14.0,
                        weight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Report Reasons
                    ...JText.reportReasons
                        .map((reason) => _buildReasonItem(reason, isDark)),

                    const SizedBox(height: 24),
                    // Additional Notes TextArea

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
                  ],
                ),
              ),
            ),

            // Action Buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: MainButton(
                      onTap: (){Navigator.pop(context);},
                      btn_title: JText.cancel,
                      btn_radius: 10,
                      btn_color: Colors.white.withValues(alpha: 0.4),
                      btn_boarder_color: JAppColors.grayBlue800,
                      title_color: isDark
                          ? JAppColors.lightGray100
                          : JAppColors.grayBlue800,
                      text_fontweight: FontWeight.w600,
                      image_value: false,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: MainButton(

                      onTap: _isLoading ? null : _handleSubmit,

                      btn_title: JText.submitReport,
                      btn_radius: 10,
                      btn_color: JAppColors.error500,
                      btn_boarder_color: Colors.transparent,
                      title_color: Colors.white,
                      text_fontweight: FontWeight.w600,
                      image_value: false,
                    ),
                  ),

                ],
              ),
            ),

            // Bottom indicator line

            SizedBox(height: 12,),



            SizedBox(height: 12,),

          ],
        ),
      ),
    );
  }

  Widget _buildReasonItem(String reason, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedReason = reason;
          });
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                reason,
                style: AppTextStyle.dmSans(
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 14.0,
                  weight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? Colors.grey[600]! : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: selectedReason == reason
                  ? Center(
                      child:
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFEE5253),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
