import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:job_contracts/presentation/features/auth/screens/Login/widgets/login_header.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/common_widgets/PhoneInputWidget.dart';
import '../../../../../utils/common_widgets/bottom_widget.dart';
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



      backgroundColor:  isDark ? JAppColors.darkGray900 : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 60, right: 16, left: 16),
          // padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               TopHeader(logo: JImages.mainLogo, title: JText.signUp, subTitle: JText.signupSubtitle, isDark: isDark,),
              TextFieldWidget(
                subTitle: JText.firstName,
                hintText: JText.firstNameText,
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
              ),

              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: JText.lastName,
                hintText: JText.lastNameText,
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: JText.email,
                hintText: JText.emailEnter,
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
              ),

              SizedBox(height: JSizes.spaceBtwInputFields ),
              RichText(
                text: TextSpan(
                  text: JText.phone,
                  style: AppTextStyle.dmSans(
                    color: isDark  ? JAppColors.lightGray100 : JAppColors.lightGray800,
                    fontSize: JSizes.fontSizeMd,
                    weight: FontWeight.w600,
                  ),
                  children: true
                      ? [
                    TextSpan(
                      text: ' *',
                      style: AppTextStyle.dmSans(
                        color: JAppColors.error600,
                        fontSize: JSizes.fontSizeMd,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ]
                      : [],
                ),
              ),
              SizedBox(height: JSizes.spaceBtwInputFields - 8),

              IntlPhoneField(
                decoration: InputDecoration(
                  fillColor:  isDark ? JAppColors.backGroundDarkCard : Colors.transparent,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'PK', // set your preferred default country
                onChanged: (phone) {
                  print('Complete phone number: ${phone.completeNumber}');
                },
                onCountryChanged: (country) {
                  print('Country changed to: ${country.name}');
                },
              ),

              TextFieldWidget(
                subTitle: JText.password,
                hintText: '*****',
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
              ),
              SizedBox(height: 4,)
,              Text(JText.passwordMustBe,style: AppTextStyle.dmSans(
                color: isDark
                    ? JAppColors.darkGray100
                    : JAppColors.lightGray500,
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w500,
              ),),

              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: JText.confirmPassword,
                hintText: '*****',
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
              ),


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
              /// Create Account


              const SizedBox(height: 30),

              BottomWidget(
                isDark: isDark,
                title: JText.alreadyAccount,
                titleDes: JText.logIn,
                onPressed: () {
                  AppRouter.router.push('/loginScreen');
                },
              ),
              const SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }
}
