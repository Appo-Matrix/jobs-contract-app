import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:async';

class ForgetPasswordOtpScreen extends StatefulWidget {
  const ForgetPasswordOtpScreen({super.key});

  @override
  State<ForgetPasswordOtpScreen> createState() =>
      _ForgetPasswordOtpScreenState();
}

class _ForgetPasswordOtpScreenState extends State<ForgetPasswordOtpScreen> {
  final List<TextEditingController> otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  int _resendTimer = 37;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _canResend = false;
    _resendTimer = 37;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  void _resendCode() {
    if (_canResend) {
      // TODO: Implement resend OTP logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification code has been resent'),
          backgroundColor: Colors.green,
        ),
      );
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String getEnteredOtp() {
    String otp = "";
    for (var controller in otpControllers) {
      otp += controller.text.trim();
    }
    return otp;
  }

  Widget buildOtpBox(int index, BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Container(
      width: 44,
      height: 54,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray700 : Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        controller: otpControllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: AppTextStyle.dmSans(
          color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
          fontSize: 24.0,
          weight: FontWeight.w600,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) {
          setState(() {});
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkBackground : Colors.white,
      appBar: JAppbar(
        leadingIcon: const Icon(Icons.arrow_back),
        leadingOnPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // Logo
                SvgPicture.asset(
                  JImages.logoSVG,
                  height: 40,
                  width: 150,
                ),

                const SizedBox(height: 48),

                // Title
                Text(
                  'Verify your mail',
                  style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.lightGray100
                        : JAppColors.darkGray800,
                    fontSize: 28.0,
                    weight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 12),

                // Subtitle with email
                RichText(
                  text: TextSpan(
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.darkGray300
                          : JAppColors.lightGray600,
                      fontSize: 14.0,
                      weight: FontWeight.w400,
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Please click the link sent to your email ',
                      ),
                      TextSpan(
                        text: 'bob@reui.io',
                        style: AppTextStyle.dmSans(
                          color: isDark
                              ? JAppColors.lightGray100
                              : JAppColors.darkGray800,
                          fontSize: 14.0,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(
                        text: ' to reset your account. Thank you',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // OTP Input Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                        (index) => buildOtpBox(index, context),
                  ),
                ),

                const SizedBox(height: 24),

                // Resend Code
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn\'t receive a code?',
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.darkGray300
                            : JAppColors.lightGray600,
                        fontSize: 14.0,
                        weight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 4),
                    if (!_canResend)
                      Text(
                        '(${_resendTimer}s)',
                        style: AppTextStyle.dmSans(
                          color: isDark
                              ? JAppColors.darkGray300
                              : JAppColors.lightGray600,
                          fontSize: 14.0,
                          weight: FontWeight.w400,
                        ),
                      ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: _resendCode,
                      child: Text(
                        'Resend',
                        style: AppTextStyle.dmSans(
                          color: _canResend
                              ? JAppColors.primary
                              : (isDark
                              ? JAppColors.darkGray400
                              : JAppColors.lightGray400),
                          fontSize: 14.0,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Continue Button
                MainButton(
                  btn_title: 'Continue',
                  btn_radius: 12,
                  btn_color: JAppColors.primary,
                  title_color: Colors.white,
                  text_fontweight: FontWeight.w600,
                  image_value: false,
                  onTap: () {
                    final otp = getEnteredOtp();
                    if (otp.length == 6) {
                      print("Entered OTP is: $otp");
                      // Navigate to reset password screen
                      AppRouter.router.push('/resetPasswordScreen');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter complete 6-digit code'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  isDark: isDark,
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}