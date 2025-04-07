import 'dart:io';

import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/terms_condition_screen/widgets/signature_section.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/common_widgets/appbar2.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/common_widgets/main_button.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  bool _agreeToTerms = false;
  bool _consentToVisibility = false;
  final _signatureController = TextEditingController();
  File? _signatureImage;
  void _onSignatureImageSelected(File? image) {
    setState(() {
      _signatureImage = image;
    });
  }
  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  void _onNextStep() {

    AppRouter.router.push('/profileDetailsScreen');
    // if (_agreeToTerms && _consentToVisibility && _signatureController.text.isNotEmpty) {
    //   // Proceed to next step
    //   print('Proceeding to verification');
    // } else {
    //   // Show error message
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(JText.pleaseAgreeAndSign),
    //       backgroundColor: JAppColors.error400,
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor:  isDark ? JAppColors.darkGray900 : Colors.white,
      appBar: JAppBar2(title: JText.back),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                JText.termsAndConditions,
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  fontSize: 28.0,
                  weight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                JText.termsAndConditions,
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.lightGray300 : JAppColors.darkGray700,
                  fontSize: JSizes.fontSizeMd,
                  weight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),

              // Terms content
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1,
                  ),
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildTermSection(
                      JText.section1Title,
                      JText.section1Content,
                      isDark,
                    ),
                    _buildTermSection(
                      JText.section2Title,
                      '',
                      isDark,
                      bulletPoints: [
                        JText.userResponsibility1,
                        JText.userResponsibility2,
                        JText.userResponsibility3,
                      ],
                    ),
                    _buildTermSection(
                      JText.section3Title,
                      JText.section3Intro,
                      isDark,
                      bulletPoints: [
                        JText.prohibitedActivity1,
                        JText.prohibitedActivity2,
                        JText.prohibitedActivity3,
                      ],
                    ),
                    _buildTermSection(
                      JText.section4Title,
                      '',
                      isDark,
                      bulletPoints: [
                        JText.payment1,
                        JText.payment2,
                        JText.payment3,
                      ],
                    ),
                    _buildTermSection(
                      JText.section5Title,
                      '',
                      isDark,
                      bulletPoints: [
                        JText.intellectualProperty1,
                        JText.intellectualProperty2,
                      ],
                    ),
                    _buildTermSection(
                      JText.section6Title,
                      JText.section6Content,
                      isDark,
                    ),
                    _buildTermSection(
                      JText.section7Title,
                      JText.section7Content,
                      isDark,
                    ),
                    _buildTermSection(
                      JText.section8Title,
                      JText.section8Content,
                      isDark,
                    ),
                    _buildTermSection(
                      JText.section9Title,
                      JText.section9Content,
                      isDark,
                    ),
                    _buildTermSection(
                      JText.section10Title,
                      JText.section10Content,
                      isDark,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Checkboxes for agreement
              _buildCheckbox(
                JText.agreeToTerms,
                _agreeToTerms,
                    (value) {
                  setState(() {
                    _agreeToTerms = value!;
                  });
                },
                isDark,
              ),

              const SizedBox(height: 16),

              _buildCheckbox(
                JText.consentToVisibility,
                _consentToVisibility,
                    (value) {
                  setState(() {
                    _consentToVisibility = value!;
                  });
                },
                isDark,
              ),

              const SizedBox(height: 24),



              SignatureSection(
                isDark: isDark,
                signatureController: _signatureController,
                onSignatureImageSelected: _onSignatureImageSelected,
              ),

              const SizedBox(height: 40),

              // Next Step Button
              MainButton(
                onTap: _onNextStep,
                btn_title: JText.nextStepVerification,
                btn_radius: 10,
                btn_color: JAppColors.primary,
                btn_boarder_color: JAppColors.primary,
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermSection(String title, String content, bool isDark, {List<String>? bulletPoints}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
            fontSize: JSizes.fontSizeMd,
            weight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        if (content.isNotEmpty)
          Text(
            content,
            style: AppTextStyle.dmSans(
              color: isDark ? JAppColors.lightGray300 : JAppColors.darkGray700,
              fontSize: 14.0,
              weight: FontWeight.w400,
            ),
          ),
        if (bulletPoints != null && bulletPoints.isNotEmpty) ...[
          const SizedBox(height: 8),
          ...bulletPoints.map((point) => _buildBulletPoint(point, isDark)),
        ],
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildBulletPoint(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: AppTextStyle.dmSans(
              color: isDark ? JAppColors.lightGray300 : JAppColors.darkGray700,
              fontSize: 14.0,
              weight: FontWeight.w400,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.dmSans(
                color: isDark ? JAppColors.lightGray300 : JAppColors.darkGray700,
                fontSize: 14.0,
                weight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String label, bool value, Function(bool?) onChanged, bool isDark) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: JAppColors.primary,
            checkColor: Colors.white,
            side: BorderSide(
              color: isDark ? JAppColors.lightGray300 : JAppColors.darkGray500,
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: AppTextStyle.dmSans(
              color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              fontSize: 14.0,
              weight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

