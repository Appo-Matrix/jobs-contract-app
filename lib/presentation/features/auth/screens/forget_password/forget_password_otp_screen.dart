import 'package:flutter/material.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/bottom_widget.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';
import 'package:pinput/pinput.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class ForgetPasswordOtpScreen extends StatefulWidget {
  const ForgetPasswordOtpScreen({super.key});

  @override
  State<ForgetPasswordOtpScreen> createState() =>
      _ForgetPasswordOtpScreenState();
}

class _ForgetPasswordOtpScreenState extends State<ForgetPasswordOtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  String get _verificationCode {
    return _controllers.map((controller) => controller.text).join();
  }

  void _onCodeChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    setState(() {});
  }

  void _resendCode() {
    print('Resending verification code...');
    // Add your resend logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('verificationCodeResent'.tr()),
        backgroundColor: const Color(0xFF7C3AED),
      ),
    );
  }

  void _verifyCode() {
    JDeviceUtils.hideKeyBoard(context);
    if (_verificationCode.length == 6) {
      print('Verifying code: $_verificationCode');
      // Add your verification logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('verificationSuccessful'.tr()),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('pleaseEnterCompleteCode'.tr()),
          backgroundColor: Colors.red,
        ),
      );
    }

    AppRouter.router.push('/resetPasswordScreen');
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray900 : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Back button

              const SizedBox(height: 20),

              // Logo Section
              Text(
                'logo',
                style: AppTextStyle.dmSans(
                  color: const Color(0xFF7C3AED),
                  fontSize: 24.0,
                  weight: FontWeight.bold,
                ),
              ).tr(),

              const SizedBox(height: 60),

              // Title
              Text(
                'verifyYourEmail',
                style: AppTextStyle.dmSans(
                  color:
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  fontSize: 24.0,
                  weight: FontWeight.w600,
                ),
              ).tr(),

              const SizedBox(height: 16),

              // Subtitle
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'pleaseEnterCodeSentOnMail'.tr(),
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.lightGray300
                            : JAppColors.darkGray600,
                        fontSize: 16.0,
                        weight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: ' bob@reui.io ',
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.lightGray100
                            : JAppColors.darkGray800,
                        fontSize: 16.0,
                        weight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: 'toResetAccount'.tr(),
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.lightGray300
                            : JAppColors.darkGray600,
                        fontSize: 16.0,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Verification Code Input
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return Container(
                    width: 45,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.lightGray100
                            : JAppColors.darkGray800,
                        fontSize: 24.0,
                        weight: FontWeight.w600,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      onChanged: (value) => _onCodeChanged(value, index),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 30),

              // Didn't receive code section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'didntReceiveCode',
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.lightGray300
                          : JAppColors.darkGray600,
                      fontSize: 14.0,
                      weight: FontWeight.w400,
                    ),
                  ).tr(),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: _resendCode,
                    child: Text(
                      'resend',
                      style: AppTextStyle.dmSans(
                        color: const Color(0xFF7C3AED),
                        fontSize: 14.0,
                        weight: FontWeight.w600,
                      ),
                    ).tr(),
                  ),
                ],
              ),

              const Spacer(),

              // Continue Button
              MainButton(
                btn_title: 'continue',
                btn_radius: 10,
                btn_color: JAppColors.primary,
                btn_boarder_color: Colors.transparent,
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                onTap: _verifyCode,
                text_size: JSizes.fontSizeMd,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
