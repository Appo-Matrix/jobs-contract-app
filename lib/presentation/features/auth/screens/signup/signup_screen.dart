import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/Login/widgets/login_header.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';



class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    String? _validateRequired(String? value) {
      if (value == null || value.trim().isEmpty) {
        return JText.requiredField;
      }
      return null;
    }
    return Scaffold(

      bottomNavigationBar:SizedBox(
        height: 50,
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                      fontSize: 16,
                      color: isDark
                          ? JAppColors.darkGray300
                          : Color(0xff667085),
                      fontWeight: FontWeight.w400),
                ),
                GestureDetector(

                  onTap: (){


                    AppRouter.router.push('/loginScreen');

                  },
                  child: Text(
                    ' Log in',
                    style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.darkGray100
                            : JAppColors.primary,
                        fontSize: 18.0,
                        weight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      backgroundColor:  isDark ? JAppColors.darkGray900 : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 60, right: 15, left: 15),
          // padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               TopHeader(logo: JImages.mainLogo, title: JText.signUp, subTitle: JText.signupSubtitle, isDark: isDark,),
              TextFieldWidget(
                subTitle: JText.firstName,
                hintText: JText.firstNameText,
                prefixIcon: Icons.person_outline,
                subtitleColor:
                isDark ? JAppColors.lightGray300 : JAppColors.darkGray900,
                titleColor:
                isDark ? JAppColors.lightGray100 : JAppColors.darkGray900,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),

              TextFieldWidget(
                validator: _validateRequired,
                subTitle: JText.lastName,
                hintText: JText.lastNameText,
                prefixIcon: Icons.person_outline,
                subtitleColor:
                isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: JText.email,
                hintText: JText.enterYourName,
                prefixIcon: Icons.person_outline,
                subtitleColor:
                isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                validator: _validateRequired,

              ),

              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                hintText: JText.createPassword,
                prefixIcon: Icons.lock_outline,
                subTitle: JText.password,
                subtitleColor:
                isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                validator: _validateRequired,

              ),
              SizedBox(height: 10),
              Text(JText.passwordMustBe,style: AppTextStyle.dmSans(
                color: isDark
                    ? JAppColors.darkGray100
                    : JAppColors.lightGray500,
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w500,
              ),),

              const SizedBox(height: 25),

              MainButton(
                onTap: (){


                  AppRouter.router.push('/addressFormScreen');
                },
                btn_title: JText.signUp,
                btn_radius: 10,
                btn_color: JAppColors.main,
                btn_boarder_color: Color(0xff7030F1),
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
              ),
              const SizedBox(height: 12),
              // MainButton(
              //   btn_title: JText.signupWithGoogle,
              //   btn_radius: 10,
              //   btn_color: Colors.transparent,
              //   btn_boarder_color: JAppColors.t,
              //   title_color: JAppColors.lightGray700,
              //   text_fontweight: FontWeight.w600,
              //   btn_image: JImages.googleImage,
              //   image_value: true,
              //   text_size: JSizes.fontSizeMd,
              // ),

              /// Create Account
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
