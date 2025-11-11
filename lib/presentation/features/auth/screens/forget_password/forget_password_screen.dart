import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetCode() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          AppRouter.router.push('/forgetPasswordOtpScreen');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        leadingIcon: const Icon(Icons.arrow_back),
        leadingOnPressed: () => Navigator.pop(context),
      ),
      backgroundColor: isDark ? JAppColors.darkBackground : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16 ,vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  // Logo
                  SvgPicture.asset(
                    JImages.logoSVG,
                    height: 40,
                    width: 190,
                  ),


                  const SizedBox(height: 32),

                  // Title
                  Text(
                    'Forgot Password?',
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.darkGray800,
                      fontSize: 28.0,
                      weight: FontWeight.w700,
                    ),
                  ).tr(),

                  const SizedBox(height: 8),
                  Text('Don\'t worry! It happens. Please enter the email address associated with your account.',
                    style: AppTextStyle.dmSans(
                      height: 1.5,
                      color: isDark
                          ? JAppColors.darkGray300
                          : JAppColors.lightGray600,
                      fontSize: 14.0,
                      weight: FontWeight.w400,
                    ),
                  ).tr(),

                  const SizedBox(height: 32),

                  // Email Input
                  TextFieldWidget(
                    textEditingController: _emailController,
                    subTitle: 'email',
                    hintText: 'emailEnter',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Basic email validation
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    subtitleColor: isDark
                        ? JAppColors.lightGray300
                        : JAppColors.grayBlue800,
                    titleColor: isDark
                        ? JAppColors.lightGray300
                        : JAppColors.grayBlue800,
                  ),

                  const SizedBox(height: 32),

                  // Send Code Button
                  MainButton(
                    btn_color: JAppColors.primary,
                    btn_title: _isLoading ? 'sending' : 'sendCode',
                    btn_radius: 12,
                    isDark: isDark,
                    title_color: Colors.white,
                    text_fontweight: FontWeight.w600,
                    image_value: false,
                    onTap: _isLoading ? null : _sendResetCode,
                  ),

                  const SizedBox(height: 24),

                  // Back to Login
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Remember your password ? ',
                          style: AppTextStyle.dmSans(
                            color: isDark
                                ? JAppColors.darkGray300
                                : JAppColors.lightGray600,
                            fontSize: 14.0,
                            weight: FontWeight.w400,
                          ),
                        ).tr(),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Login',
                            style: AppTextStyle.dmSans(
                              color: JAppColors.primary,
                              fontSize: 14.0,
                              weight: FontWeight.w600,
                            ),
                          ).tr(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Help Section

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}