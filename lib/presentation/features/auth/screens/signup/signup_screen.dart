import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

import 'package:easy_localization/easy_localization.dart' as easy;


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    String? _validateRequired(String? value) {
      if (value == null || value.trim().isEmpty) {
        return 'requiredField';
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
               TopHeader(logo: JImages.mainLogo, title: 'signUp', subTitle: 'signupSubtitle', isDark: isDark,),
              TextFieldWidget(
                subTitle: 'firstName',
                hintText: 'firstNameText',
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
              ),

              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: 'lastName',
                hintText: 'lastNameText',
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: 'email',
                hintText: 'emailEnter',
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
              ),

              SizedBox(height: JSizes.spaceBtwInputFields ),
              RichText(
                text: TextSpan(
                  text: easy.tr('phone'),
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
                subTitle: 'password',
                hintText: '*****',
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
              ),
              SizedBox(height: 4,)
,              Text('passwordMustBe',style: AppTextStyle.dmSans(
                color: isDark
                    ? JAppColors.darkGray100
                    : JAppColors.lightGray500,
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w500,
              ),).tr(),

              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: 'confirmPassword',
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
                btn_title: 'signUp',
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
                title: 'alreadyAccount',
                titleDes: 'logIn',
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
