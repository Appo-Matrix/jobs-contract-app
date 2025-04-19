import 'dart:io';

import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/terms_condition_screen/widgets/custom_checkbox_widget.dart';
import 'package:job_contracts/presentation/features/auth/screens/terms_condition_screen/widgets/signature_section.dart';
import 'package:job_contracts/presentation/features/auth/screens/terms_condition_screen/widgets/term_section_widget.dart';
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
      backgroundColor:  isDark ? JAppColors.backGroundDark : Colors.white,
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
                  fontSize: 24.0,
                  weight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                JText.termsAndConditions,
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.lightGray300 : JAppColors.darkGray700,
                  fontSize: JSizes.fontSizeSm,
                  weight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),


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
                    TermSectionWidget(
                      title: JText.section1Title,
                      content: JText.section1Content,
                      isDark: isDark,
                    ),
                    TermSectionWidget(
                      title: JText.section2Title,
                      content: '',
                      isDark: isDark,
                      bulletPoints: [
                        JText.userResponsibility1,
                        JText.userResponsibility2,
                        JText.userResponsibility3,
                      ],
                    ),
                    TermSectionWidget(
                      title: JText.section3Title,
                      content: JText.section3Intro,
                      isDark: isDark,
                      bulletPoints: [
                        JText.prohibitedActivity1,
                        JText.prohibitedActivity2,
                        JText.prohibitedActivity3,
                      ],
                    ),
                    TermSectionWidget(
                      title: JText.section4Title,
                      content: '',
                      isDark: isDark,
                      bulletPoints: [
                        JText.payment1,
                        JText.payment2,
                        JText.payment3,
                      ],
                    ),
                    TermSectionWidget(
                      title: JText.section5Title,
                      content: '',
                      isDark: isDark,
                      bulletPoints: [
                        JText.intellectualProperty1,
                        JText.intellectualProperty2,
                      ],
                    ),
                    TermSectionWidget(
                      title: JText.section6Title,
                      content: JText.section6Content,
                      isDark: isDark,
                    ),
                    TermSectionWidget(
                      title: JText.section7Title,
                      content: JText.section7Content,
                      isDark: isDark,
                    ),
                    TermSectionWidget(
                      title: JText.section8Title,
                      content: JText.section8Content,
                      isDark: isDark,
                    ),
                    TermSectionWidget(
                      title: JText.section9Title,
                      content: JText.section9Content,
                      isDark: isDark,
                    ),
                    TermSectionWidget(
                      title: JText.section10Title,
                      content: JText.section10Content,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 24),
            CustomCheckboxWidget(
              label: JText.agreeToTerms,
              value: _agreeToTerms,
              isDark: isDark,
              onChanged: (bool? newValue) {
                setState(() {
                  _agreeToTerms = newValue ?? false;
                });
              },
            ),
              const SizedBox(height: 16),

              CustomCheckboxWidget(
              label: JText.consentToVisibility,
              value: _consentToVisibility,
              isDark: isDark,
              onChanged: (bool? newValue) {
                setState(() {
                  _consentToVisibility = newValue ?? false;
                });
              },
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
                btn_title: JText.nextStep,
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


}

