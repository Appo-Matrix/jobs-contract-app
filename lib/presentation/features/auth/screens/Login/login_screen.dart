// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:job_contracts/presentation/features/auth/screens/Login/widgets/login_header.dart';
// import 'package:job_contracts/presentation/routes/app_routes.dart';
// import 'package:job_contracts/utils/constants/colors.dart';
// import 'package:job_contracts/utils/constants/image_string.dart';
// import 'package:job_contracts/utils/constants/sizes.dart';
// import 'package:job_contracts/utils/constants/text_strings.dart';
// import 'package:job_contracts/utils/messages/messages.dart';
// import '../../../../../utils/common_widgets/bottom_widget.dart';
// import '../../../../../utils/common_widgets/main_button.dart';
// import '../../../../../utils/common_widgets/text_field_widget.dart';
// import '../../../../../utils/constants/app_text_style.dart';
// import '../../../../../utils/device/device_utility.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   bool _obscureText = true;
//   bool _rememberMe = false;
//
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   String? _validateRequired(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return JText.requiredField;
//     }
//     return null;
//   }
//
//   void _togglePasswordVisibility() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }
//
//   void _handleLogin() {
//     JDeviceUtils.hideKeyBoard(context);
//
//     if (_formKey.currentState?.validate() ?? false) {
//       AppRouter.router.push('/navigationMenu');
//     } else {
//       Messages.flashBarErrorMessage(
//         'Please fill all required fields',
//         context,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//
//     return Scaffold(
//       backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: JSizes.spaceBtwSections + 10),
//
//                 TopHeader(
//                   logo: JImages.logoSVG,
//                   logoHeight: 42,
//                   title: 'logIn',
//                   subTitle: 'loginTitle',
//                   isDark: isDark,
//                 ),
//
//                 const SizedBox(height: JSizes.spaceBtwItems - 10),
//                 const SizedBox(height: JSizes.spaceBtwItems ),
//                 const SizedBox(height: JSizes.spaceBtwItems - 10),
//
//                 TextFieldWidget(
//                   textEditingController: _emailController,
//                   subTitle: 'email',
//                   hintText: 'emailEnter',
//
//                   subtitleColor: isDark
//                       ? JAppColors.lightGray100
//                       : JAppColors.darkGray800,
//                   titleColor: isDark
//                       ? JAppColors.lightGray100
//                       : JAppColors.darkGray800,
//                   isRequired: true,
//                   validator: _validateRequired,
//                 ),
//
//                 const SizedBox(height: JSizes.spaceBtwInputFields),
//
//                 TextFieldWidget(
//                   textEditingController: _passwordController,
//                   subTitle: 'password',
//                   hintText: '******',
//                   isRequired: true,
//                   subtitleColor: isDark
//                       ? JAppColors.lightGray100
//                       : JAppColors.darkGray800,
//                   titleColor: isDark
//                       ? JAppColors.lightGray100
//                       : JAppColors.darkGray800,
//                   obscureText: _obscureText,
//                   validator: _validateRequired,
//                   suffixIcon: GestureDetector(
//                     onTap: _togglePasswordVisibility,
//                     child: Icon(
//                       _obscureText
//                           ? CupertinoIcons.eye
//                           : CupertinoIcons.eye_slash,
//                     ),
//                   ),
//                 ),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Checkbox(
//                       value: _rememberMe,
//                       onChanged: (value) {
//                         setState(() {
//                           _rememberMe = value ?? false;
//                         });
//                       },
//                       side: BorderSide(
//                         color: isDark
//                             ? JAppColors.darkGray100
//                             : JAppColors.lightGray800,
//                         width: 1.6,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                     ),
//                     Text(
//                       'remember',
//                       style: AppTextStyle.dmSans(
//                         color: isDark
//                             ? JAppColors.darkGray100
//                             : JAppColors.lightGray800,
//                         fontSize: JSizes.fontSizeESm,
//                         weight: FontWeight.w500,
//                       ),
//                     ).tr(),
//                     const Spacer(),
//                     TextButton(
//                       onPressed: () {
//                         AppRouter.router.push('/forgetPasswordScreen');
//                       },
//                       child: Text(
//                         'forgetPassword',
//                         style: AppTextStyle.dmSans(
//                           color: isDark
//                               ? JAppColors.darkGray100
//                               : JAppColors.primary,
//                           fontSize: JSizes.fontSizeEaSm,
//                           weight: FontWeight.w600,
//                         ),
//                       ).tr(),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: JSizes.spaceBtwSections),
//
//                 MainButton(
//                   btn_title: 'signIn',
//                   btn_radius: 8,
//                   btn_color: JAppColors.main,
//                   title_color: Colors.white,
//                   text_fontweight: FontWeight.w600,
//                   image_value: false,
//                   onTap: _handleLogin,
//                 ),
//
//                 const SizedBox(height: JSizes.spaceBtwSections ),
//                 MainButton(
//                   btn_image: JImages.googleImage,
//
//                   height: 52,
//                   btn_title: "Sign in with Google",
//                   btn_radius: 10,
//                   title_color:
//                   isDark ? JAppColors.darkGray100 : JAppColors.lightGray700,
//                   text_fontweight: FontWeight.w600,
//                   image_value: true,
//                   btn_color: Colors.white,
//                   btn_border_color:    isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//
//                   onTap: () {},
//                   text_size: JSizes.fontSizeMd,
//                 ),
//                 const SizedBox(height: JSizes.spaceBtwSections ),
//
//                 Row(
//                   children: [
//                     const Expanded(
//                       child: Divider(color: JAppColors.darkGray300),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text(
//                         'OR',
//                         style: AppTextStyle.dmSans(
//                           color: isDark
//                               ? JAppColors.darkGray100
//                               : JAppColors.lightGray500,
//                           fontSize: JSizes.fontSizeEaSm,
//                           weight: FontWeight.w600,
//                         ),
//                       ).tr(),
//                     ),
//                     const Expanded(
//                       child: Divider(color: JAppColors.darkGray300),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: JSizes.spaceBtwSections),
//
//                 BottomWidget(
//                   isDark: isDark,
//                   title: 'donotHaveAccount',
//                   titleDes: 'signUp',
//                   onPressed: () {
//                     AppRouter.router.push('/newSignupScreen');
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/Login/widgets/login_header.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:job_contracts/utils/messages/messages.dart';
import '../../../../../utils/common_widgets/bottom_widget.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _rememberMe = false;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return JText.requiredField;
    }
    return null;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _handleLogin() {
    JDeviceUtils.hideKeyBoard(context);

    if (_formKey.currentState?.validate() ?? false) {
      AppRouter.router.push('/navigationMenu');
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Responsive top spacing based on screen height
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
                  textEditingController: _emailController,
                  subTitle: 'email',
                  hintText: 'emailEnter',
                  subtitleColor: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                  titleColor: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                  isRequired: true,
                  validator: _validateRequired,
                ),

                const SizedBox(height: JSizes.spaceBtwInputFields),

                TextFieldWidget(
                  textEditingController: _passwordController,
                  subTitle: 'password',
                  hintText: '******',
                  isRequired: true,
                  subtitleColor: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                  titleColor: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                  obscureText: _obscureText,
                  validator: _validateRequired,
                  suffixIcon: GestureDetector(
                    onTap: _togglePasswordVisibility,
                    child: Icon(
                      _obscureText
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                    ),
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
                  btn_title: 'signIn',
                  btn_radius: 8,
                  btn_color: JAppColors.main,
                  title_color: Colors.white,
                  text_fontweight: FontWeight.w600,
                  image_value: false,
                  onTap: _handleLogin,
                ),

                const SizedBox(height: JSizes.spaceBtwSections),

                MainButton(
                  btn_image: JImages.googleImage,
                  height: 52,
                  btn_title: "Sign in with Google",
                  btn_radius: 10,
                  title_color:
                  isDark ? JAppColors.darkGray100 : JAppColors.lightGray700,
                  text_fontweight: FontWeight.w600,
                  image_value: true,
                  btn_color: Colors.white,
                  btn_border_color:
                  isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  onTap: () {},
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
      ),
    );
  }
}