// Imports remain the same
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppBar2(title: 'back'.tr()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'termsAndConditions'.tr(),
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  fontSize: 24.0,
                  weight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'termsAndConditions'.tr(),
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
                  border: Border.all(color: Colors.transparent, width: 1),
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    TermSectionWidget(
                      title: 'section1Title'.tr(),
                      content: 'section1Content'.tr(),
                      isDark: isDark,
                    ),
                    TermSectionWidget(
                      title: 'section2Title'.tr(),
                      content: '',
                      isDark: isDark,
                      bulletPoints: [
                        'userResponsibility1'.tr(),
                        'userResponsibility2'.tr(),
                        'userResponsibility3'.tr(),
                      ],
                    ),
                    TermSectionWidget(
                      title: 'section3Title'.tr(),
                      content: 'section3Intro'.tr(),
                      isDark: isDark,
                      bulletPoints: [
                        'prohibitedActivity1'.tr(),
                        'prohibitedActivity2'.tr(),
                        'prohibitedActivity3'.tr(),
                      ],
                    ),
                    TermSectionWidget(
                      title: 'section4Title'.tr(),
                      content: '',
                      isDark: isDark,
                      bulletPoints: [
                        'payment1'.tr(),
                        'payment2'.tr(),
                        'payment3'.tr(),
                      ],
                    ),
                    TermSectionWidget(
                      title: 'section5Title'.tr(),
                      content: '',
                      isDark: isDark,
                      bulletPoints: [
                        'intellectualProperty1'.tr(),
                        'intellectualProperty2'.tr(),
                      ],
                    ),
                    TermSectionWidget(
                      title: 'section6Title'.tr(),
                      content: 'section6Content'.tr(),
                      isDark: isDark,
                    ),
                    TermSectionWidget(
                      title: 'section7Title'.tr(),
                      content: 'section7Content'.tr(),
                      isDark: isDark,
                    ),
                    TermSectionWidget(
                      title: 'section8Title'.tr(),
                      content: 'section8Content'.tr(),
                      isDark: isDark,
                    ),
                    TermSectionWidget(
                      title: 'section9Title'.tr(),
                      content: 'section9Content'.tr(),
                      isDark: isDark,
                    ),
                    TermSectionWidget(
                      title: 'section10Title'.tr(),
                      content: 'section10Content'.tr(),
                      isDark: isDark,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              CustomCheckboxWidget(
                label: 'agreeToTerms'.tr(),
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
                label: 'consentToVisibility'.tr(),
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
              MainButton(
                onTap: _onNextStep,
                btn_title: 'nextStep'.tr(),
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
