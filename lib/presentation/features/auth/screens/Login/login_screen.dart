import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contract_app/presentation/features/auth/screens/Login/widgets/login_header.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/common_widgets/bottom_widget.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/messages/messages.dart';
import '../../../../routes/app_routes.dart';
import '../../../users/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _rememberMe = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return JText.requiredField;
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return JText.requiredField;
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _handleLogin(AuthProvider authProvider) async {
    JDeviceUtils.hideKeyBoard(context);

    if (_formKey.currentState?.validate() ?? false) {
      final success = await authProvider.loginWithEmail(context);
      if (success && mounted) {
        // Navigate to home/navigation menu
        AppRouter.router.pushReplacement('/navigationMenu');
      }
    } else {
      Messages.flashBarErrorMessage(
        'Please fill all required fields',
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.06),

                    TopHeader(
                      logo: JImages.logoSVG,
                      logoHeight: 42,
                      title: 'logIn',
                      subTitle: 'loginTitle',
                      isDark: isDark,
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    TextFieldWidget(
                      textEditingController: authProvider.emailController,
                      subTitle: 'email',
                      hintText: 'emailEnter',
                      subtitleColor: isDark
                          ? JAppColors.lightGray100
                          : JAppColors.darkGray800,
                      titleColor: isDark
                          ? JAppColors.lightGray100
                          : JAppColors.darkGray800,
                      isRequired: true,
                      isEmail: true,
                      validator: _validateEmail,
                    ),

                    const SizedBox(height: JSizes.spaceBtwInputFields),
                    const SizedBox(height: JSizes.spaceBtwInputFields),

                    TextFieldWidget(
                      textEditingController: authProvider.passwordController,
                      subTitle: 'password',
                      hintText: '******',
                      isRequired: true,
                      isPassword: true,   // ✅ just add this

                      onSuffixIconPressed: _togglePasswordVisibility,
                      subtitleColor: isDark
                          ? JAppColors.lightGray100
                          : JAppColors.darkGray800,
                      titleColor: isDark
                          ? JAppColors.lightGray100
                          : JAppColors.darkGray800,
                      obscureText: _obscureText,
                      validator: _validateRequired,
                      suffixIcon: Icon(
                        _obscureText
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash,
                      ),
                    ),

                    const SizedBox(height: JSizes.spaceBtwItems),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                          side: BorderSide(
                            color: isDark
                                ? JAppColors.darkGray100
                                : JAppColors.lightGray800,
                            width: 1.6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Text(
                          'remember',
                          style: AppTextStyle.dmSans(
                            color: isDark
                                ? JAppColors.darkGray100
                                : JAppColors.lightGray800,
                            fontSize: JSizes.fontSizeESm,
                            weight: FontWeight.w500,
                          ),
                        ).tr(),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            AppRouter.router.push('/forgetPasswordScreen');
                          },
                          child: Text(
                            'forgetPassword',
                            style: AppTextStyle.dmSans(
                              color: isDark
                                  ? JAppColors.darkGray100
                                  : JAppColors.primary,
                              fontSize: JSizes.fontSizeEaSm,
                              weight: FontWeight.w600,
                            ),
                          ).tr(),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    MainButton(
                      btn_title: authProvider.isLoading ? 'Signing in...' : 'signIn',
                      btn_radius: 8,
                      btn_color: JAppColors.main,
                      title_color: Colors.white,
                      text_fontweight: FontWeight.w600,
                      image_value: false,
                      onTap: authProvider.isLoading
                          ? null
                          : () => _handleLogin(authProvider),
                    ),

                    const SizedBox(height: JSizes.spaceBtwSections),

                    MainButton(
                      btn_image: JImages.googleImage,
                      height: 52,
                      btn_title: "Sign in with Google",
                      btn_radius: 10,
                      title_color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray700,
                      text_fontweight: FontWeight.w600,
                      image_value: true,
                      btn_color: Colors.white,
                      btn_border_color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray800,
                      onTap: () {
                        // TODO: Implement Google Sign-in
                      },
                      text_size: JSizes.fontSizeMd,
                    ),

                    const SizedBox(height: JSizes.spaceBtwSections),

                    Row(
                      children: [
                        const Expanded(
                          child: Divider(color: JAppColors.darkGray300),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'OR',
                            style: AppTextStyle.dmSans(
                              color: isDark
                                  ? JAppColors.darkGray100
                                  : JAppColors.lightGray500,
                              fontSize: JSizes.fontSizeEaSm,
                              weight: FontWeight.w600,
                            ),
                          ).tr(),
                        ),
                        const Expanded(
                          child: Divider(color: JAppColors.darkGray300),
                        ),
                      ],
                    ),

                    const SizedBox(height: JSizes.spaceBtwSections),

                    BottomWidget(
                      isDark: isDark,
                      title: 'donotHaveAccount',
                      titleDes: 'signUp',
                      onPressed: () {
                        AppRouter.router.push('/newSignupScreen');
                      },
                    ),

                    const SizedBox(height: JSizes.spaceBtwItems),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}




