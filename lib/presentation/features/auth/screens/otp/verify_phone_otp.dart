import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/verify_profile/screens/widgets/buildOtpBox.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:pinput/pinput.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';

class VerifyPhoneOtp extends StatefulWidget {
  const VerifyPhoneOtp({super.key});

  @override
  State<VerifyPhoneOtp> createState() => _VerifyPhoneOtpState();
}

class _VerifyPhoneOtpState extends State<VerifyPhoneOtp> {
  final TextEditingController otpController = TextEditingController();
  bool _isLoading = false;
  int _resendTimer = 60;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    setState(() {
      _resendTimer = 60;
    });

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_resendTimer > 0 && mounted) {
        setState(() {
          _resendTimer--;
        });
        return true;
      }
      return false;
    });
  }

  void _verifyOtp() async {
    if (otpController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter complete 6-digit OTP'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Phone number verified successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back to verify profile screen
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.pop(context); // Go back to phone number screen
          Navigator.pop(context); // Go back to verify profile screen
        }
      });
    }
  }

  void _resendOtp() async {
    if (_resendTimer > 0) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      _startResendTimer();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP resent successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: AppTextStyle.dmSans(
        color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
        fontSize: 24.0,
        weight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: isDark ? Colors.transparent : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray400,
          width: 1,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(
          color: JAppColors.primary,
          width: 1.5,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      appBar: JAppbar(
        title: Text(
          'Verify OTP',
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: 18.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: Icon(Icons.arrow_back),
        leadingOnPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Icon
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: JAppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.phone_android,
                  size: 50,
                  color: JAppColors.primary,
                ),
              ),

              const SizedBox(height: 30),

              // Title
              Text(
                'Enter Verification Code',
                textAlign: TextAlign.center,
                style: AppTextStyle.dmSans(
                  color: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                  fontSize: 24.0,
                  weight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              // Description
              Text(
                'We have sent a 6-digit code to your phone number',
                textAlign: TextAlign.center,
                style: AppTextStyle.dmSans(
                  color: isDark
                      ? JAppColors.lightGray400
                      : JAppColors.darkGray600,
                  fontSize: 14.0,
                  weight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 40),

              // OTP Input using Pinput
              Pinput(
                controller: otpController,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                onCompleted: (pin) {
                  // Auto verify when all digits are entered
                  _verifyOtp();
                },
                enabled: !_isLoading,
              ),

              SizedBox(height: JSizes.spaceBtwSections),

              // Resend OTP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive code? ",
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.lightGray400
                          : JAppColors.darkGray600,
                      fontSize: 14.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: _resendTimer == 0 ? _resendOtp : null,
                    child: Text(
                      _resendTimer > 0
                          ? 'Resend in ${_resendTimer}s'
                          : 'Resend',
                      style: AppTextStyle.dmSans(
                        color: _resendTimer > 0
                            ? (isDark
                            ? JAppColors.lightGray400
                            : JAppColors.darkGray600)
                            : JAppColors.primary,
                        fontSize: 14.0,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: JSizes.spaceBtwSections + 30),

              // Verify Button
              MainButton(
                btn_title: _isLoading ? 'Verifying...' : 'Verify',
                btn_radius: 10,
                btn_color: JAppColors.main,
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                onTap: _isLoading ? null : _verifyOtp,
              ),

              const SizedBox(height: 16),

              // Change Number
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Change Phone Number',
                  style: AppTextStyle.dmSans(
                    color: JAppColors.primary,
                    fontSize: 14.0,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}