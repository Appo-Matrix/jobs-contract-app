import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/Login/widgets/login_header.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50, right: 15, left: 15),
          // padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopHeader(),
              TextFieldWidget(
                subTitle: PText.email,
                hintText: PText.emailEnter,
                prefixIcon: Icons.person_outline,
              ),

              SizedBox(height: 20),

              TextFieldWidget(
                hintText: '••••••••',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
                subTitle: PText.password,
              ),

              //const TLoginForm(),
              // TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                    side: BorderSide(
                      color: JAppColors.lightGray400,
                      // Border color changes based on checkbox state
                      width: 1.6, // You can adjust the width as well
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Rounded corners
                    ),
                  ),
                  Text(
                    PText.remember,
                    style: AppTextStyle.dmSans(
                      color: JAppColors.lightGray700,
                      fontSize: JSizes.fontSizeESm,
                      weight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      PText.forgetPassword,
                      style: AppTextStyle.dmSans(
                        color: JAppColors.main,
                        fontSize: JSizes.fontSizeEaSm,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              ///SignIn Button
              const SizedBox(height: 20),

              MainButton(
                btn_title: PText.signIn,
                btn_radius: 10,
                btn_color: JAppColors.main,
                btn_boarder_color: Color(0xff7030F1),
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
              ),
              const SizedBox(height: 20),
              MainButton(
                btn_title: PText.signInGoogle,
                btn_radius: 10,
                btn_color: Colors.transparent,
                btn_boarder_color: JAppColors.t,
                title_color: JAppColors.lightGray700,
                text_fontweight: FontWeight.w600,
                btn_image: PImages.googleImage,
                image_value: true,
                text_size: JSizes.fontSizeMd,
              ),

              /// Create Account
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    PText.account,
                    style: AppTextStyle.dmSans(
                      color: JAppColors.lightGray500,
                      fontSize: JSizes.fontSizeMd,
                      weight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    PText.signUp,
                    style: AppTextStyle.dmSans(
                      color: JAppColors.primary,
                      fontSize: JSizes.fontSizeLg,
                      weight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
