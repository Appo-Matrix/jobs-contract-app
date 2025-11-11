import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/presentation/features/auth/screens/forget_password/widgets/requirement_item.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      if (_newPasswordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password reset successful!'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to login screen
          AppRouter.router.go('/passwordUpdatedScreen');
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
        leadingOnPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0 ,vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Logo
                  SvgPicture.asset(
                    JImages.logoSVG,
                    height: 40,
                    width: 150,
                  ),

                  const SizedBox(height: 38),

                  // Title
                  Text(
                    'Reset Password',
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.lightGray100
                          : JAppColors.darkGray800,
                      fontSize: 28.0,
                      weight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'Enter your new password',
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.darkGray300
                          : JAppColors.lightGray600,
                      fontSize: 14.0,
                      weight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 32),



                  const SizedBox(height: 8),

                  TextFieldWidget(
                    subTitle: 'Enter Password',
                    hintText: '******',
                    subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                    titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                    isRequired: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),

                  // New Password Field

                  const SizedBox(height: 20),

                  // Confirm Password Label
                  TextFieldWidget(
                    subTitle: 'Confirm Password',
                    hintText: '******',
                    subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                    titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                    isRequired: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),



                  const SizedBox(height: 32),

                  // Continue Button
                  MainButton(
                    btn_title: _isLoading ? 'Processing...' : 'Continue',
                    btn_radius: 12,
                    btn_color: JAppColors.primary,
                    title_color: Colors.white,
                    text_fontweight: FontWeight.w600,
                    image_value: false,
                    onTap: _isLoading ? null : _resetPassword,
                    isDark: isDark,
                  ),

                  const SizedBox(height: 32),

                  // Password Requirements
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password must contain:',
                          style: AppTextStyle.dmSans(
                            color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                            fontSize: 14.0,
                            weight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // ✅ Using reusable widget
                        RequirementItem(text: 'At least 8 characters', isDark: isDark),
                        const SizedBox(height: 6),
                        RequirementItem(
                            text: 'Mix of uppercase & lowercase letters', isDark: isDark),
                        const SizedBox(height: 6),
                        RequirementItem(text: 'At least one number', isDark: isDark),
                        const SizedBox(height: 6),
                        RequirementItem(text: 'At least one special character', isDark: isDark),
                      ],
                    ),
                  )
,
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