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
import 'package:provider/provider.dart';
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
  String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return JText.requiredField;
    }
    return null;
  }

  bool obscureText = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);


    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          // padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: JSizes.spaceBtwSections + 10,
              ),
              TopHeader(
                logo: JImages.mainLogo,
                title: 'logIn',
                subTitle: 'loginTitle',
                isDark: isDark,
              ),
              SizedBox(
                height: JSizes.spaceBtwItems - 10,
              ),

              TextFieldWidget(
                textEditingController: emailController,
                subTitle: 'email',
                hintText: 'emailEnter',
                subtitleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: validateRequired,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),

              TextFieldWidget(
                textEditingController: passwordController,
                subTitle: 'password',
                hintText: '******',
                isRequired: true,
                subtitleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                obscureText: obscureText,
                validator: validateRequired,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      // Add setState here
                      obscureText = !obscureText;
                      print('Click');
                    });
                  },
                  child: Icon(obscureText
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash),
                ),
              ),



              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                    side: BorderSide(
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray800,
                      // Border color changes based on checkbox state
                      width: 1.6, // You can adjust the width as well
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Rounded corners
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
                  Spacer(),
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

              ///SignIn Button
              SizedBox(height: JSizes.spaceBtwSections),

              MainButton(
                btn_title: 'signIn',
                btn_radius: 8,
                btn_color: JAppColors.main,
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                onTap: () {
                  JDeviceUtils.hideKeyBoard(context);
                  final emailError = validateRequired(emailController.text);
                  final passwordError =
                      validateRequired(passwordController.text);
                  // Messages.flashBarErrorMessage( 'login button pressed',context);
                  if (emailError != null || passwordError != null) {
                    // Show error message if validation fails
                    Messages.flashBarErrorMessage(
                        'Please fill all required fields', context);
                  } else {
                    Map data = {
                      "email": "shoaib.sahirrr@gmail.com",
                      "password": "securePassword123"
                    };

                    // Proceed with login if validation passes
                    Messages.flashBarErrorMessage(
                        'login button pressed', context);
                    AppRouter.router.push('/navigationMenu');
                  }
                  // AppRouter.router.push('/navigationMenu');
                },
                btn_boarder_color: JAppColors.primary,
              ),


              SizedBox(height: JSizes.spaceBtwSections+10,),

              Row(
                children: [
                  Expanded(child: Divider(color:JAppColors.darkGray300,)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
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
                  Expanded(child: Divider(color:JAppColors.darkGray300,)),

                ],
              ),
              SizedBox(height: JSizes.spaceBtwSections,),
              Row(
                children: [

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MainButton(
                        btn_image: JImages.googleImage,

                        height: 40,
                        btn_title: "User Google",
                        btn_radius: 10,
                        btn_color: Colors.transparent,
                        btn_boarder_color: JAppColors.t,
                        title_color:
                        isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                        text_fontweight: FontWeight.w600,
                        image_value: true,
                        onTap: () {},
                        text_size: JSizes.fontSizeMd,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MainButton(
                        height: 40,

                        btn_title: 'User Apple',
                        btn_radius: 10,
                        btn_color: Colors.transparent,
                        btn_boarder_color: JAppColors.t,
                        title_color:
                            isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                        text_fontweight: FontWeight.w600,

                        btn_image: JImages.appleLogo,

                        image_value: true,
                        onTap: () {},
                        text_size: JSizes.fontSizeMd,
                      ),
                    ),
                  ),
                ],
              ),


              SizedBox(height: JSizes.spaceBtwSections,),
              BottomWidget(
                isDark: isDark,
                title: 'donotHaveAccount',
                titleDes: 'signUp',
                onPressed: () {
                  AppRouter.router.push('/signupScreen');
                },
              ),




              /// Create Account
            ],
          ),
        ),
      ),
    );
  }
}
