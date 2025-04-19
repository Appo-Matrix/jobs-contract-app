import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/Login/widgets/login_header.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../utils/common_widgets/bottom_widget.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,

      bottomNavigationBar:SizedBox(
        height: 50,
        child: Column(
          children: [
            BottomWidget(
              isDark: isDark,
              title: JText.donotHaveAccount,
              titleDes: JText.signUp,
              onPressed: () {
                AppRouter.router.push('/accountCreationScreen');
              },
            ),

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16 ,horizontal: 16),
          // padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: JSizes.spaceBtwSections+10,),
               TopHeader(logo: JImages.mainLogo, title: JText.login, subTitle: JText.loginTitle, isDark: isDark,),
              SizedBox(height: JSizes.spaceBtwItems -10,),


              TextFieldWidget(
                subTitle: JText.email,
                hintText: JText.emailEnter,
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),

              TextFieldWidget(
                subTitle: JText.password,
                hintText: '******',
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
              ),


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
                    JText.remember,
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray800,
                      fontSize: JSizes.fontSizeESm,
                      weight: FontWeight.w500,
                    ),
                  ),

                  Spacer(),
                  TextButton(
                    onPressed: () {

                      AppRouter.router.push('/forgetPasswordScreen');


                    },
                    child: Text(
                      JText.forgetPassword,
                      style: AppTextStyle.dmSans(
                        color: isDark
                      ? JAppColors.darkGray100
                          : JAppColors.primary,
                        fontSize: JSizes.fontSizeEaSm,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              ///SignIn Button
               SizedBox(height: JSizes.spaceBtwSections),

              MainButton(
                btn_title: JText.signIn,
                btn_radius: 8,
                btn_color: JAppColors.main,
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,onTap: (){
                  
                  AppRouter.router.push('/navigationMenu');
                  
              }, btn_boarder_color: JAppColors.primary,
              ),
              SizedBox(height: JSizes.spaceBtwItems),
              MainButton(
                btn_title: JText.signInGoogle,
                btn_radius: 10,
                btn_color: Colors.transparent,
                btn_boarder_color: JAppColors.t,
                title_color: isDark
              ? JAppColors.darkGray100
                  : JAppColors.lightGray800,
                text_fontweight: FontWeight.w600,
                btn_image: JImages.googleImage,
                image_value: true,
                onTap: (){},

                text_size: JSizes.fontSizeMd,
              ),

              /// Create Account
               SizedBox(height: JSizes.spaceBtwSections+10),



            ],
          ),
        ),
      ),
    );
  }
}
