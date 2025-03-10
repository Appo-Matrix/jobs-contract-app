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

    return Scaffold(

      bottomNavigationBar:SizedBox(
        height: 50,
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  JText.account,
                  style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.lightGray700,
                    fontSize: JSizes.fontSizeMd,
                    weight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 5),

                GestureDetector(
                  onTap: (){
                    AppRouter.router.push('/signupScreen');


                  },
                  child: Text(
                    JText.signUp,
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.darkGray200
                          : JAppColors.primary,
                      fontSize: JSizes.fontSizeLg,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      backgroundColor: isDark ? JAppColors.darkGray800 : JAppColors.lightGray100,
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
                subTitle: JText.signUpTitle,
                hintText: JText.signUpName,
                prefixIcon: Icons.person_outline,
              ),
              SizedBox(height: 20),
              TextFieldWidget(
                subTitle: JText.email,
                hintText: JText.enterYourName,
                prefixIcon: Icons.person_outline,
              ),

              SizedBox(height: 20),
              TextFieldWidget(
                hintText: JText.createPassword,
                prefixIcon: Icons.lock_outline,
                subTitle: JText.password,
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
