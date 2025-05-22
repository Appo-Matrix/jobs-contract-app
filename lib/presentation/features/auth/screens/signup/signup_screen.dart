import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:job_contracts/presentation/features/auth/screens/Login/widgets/login_header.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';

import '../../../../../utils/common_widgets/bottom_widget.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';

import 'package:easy_localization/easy_localization.dart' as easy;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'requiredField';
    }
    return null;
  }

  // Updated dropdown selection variables with translation keys
  String selectedUserType = 'contractor'; // Default value (translation key)
  List<String> userTypeKeys = ['contractor', 'company',]; // Translation keys

  // Function to handle dropdown change
  void updateUserType(String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedUserType = newValue;
        // You can add additional logic here if needed when user type changes
        print('User type changed to: $selectedUserType');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray900 : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 60, right: 16, left: 16),
          // padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopHeader(
                logo: JImages.mainLogo,
                title: 'signUp',
                subTitle: '',
                isDark: isDark,
              ),
              TextFieldWidget(
                subTitle: 'firstName',
                hintText: 'firstNameText',
                subtitleColor:
                isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor:
                isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: validateRequired,
              ),

              SizedBox(height: JSizes.inputFieldRadius),
              TextFieldWidget(
                subTitle: 'lastName',
                hintText: 'lastNameText',
                subtitleColor:
                isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor:
                isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: validateRequired,
              ),
              SizedBox(height: JSizes.inputFieldRadius),
              TextFieldWidget(
                subTitle: 'email',
                hintText: 'emailEnter',
                subtitleColor:
                isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor:
                isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: validateRequired,
              ),
              SizedBox(height: JSizes.inputFieldRadius),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'role',
                        style: AppTextStyle.dmSans(
                          color: isDark
                              ? JAppColors.lightGray100
                              : JAppColors.darkGray800,
                          fontSize: JSizes.fontSizeEaSm,
                          weight: FontWeight.w500,
                        ),
                      ).tr(),
                      Text(
                        ' *',
                        style: AppTextStyle.dmSans(
                          color: Colors.red,
                          fontSize: JSizes.fontSizeEaSm,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark
                            ? JAppColors.darkGray300
                            : JAppColors.lightGray300,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedUserType,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 24,
                        elevation: 16,
                        style: AppTextStyle.dmSans(
                          color: isDark
                              ? JAppColors.lightGray100
                              : JAppColors.darkGray800,
                          fontSize: JSizes.fontSizeEaSm,
                          weight: FontWeight.w400,
                        ),
                        dropdownColor:
                        isDark ? JAppColors.backGroundDark : Colors.white,
                        onChanged: (String? newValue) {
                          updateUserType(newValue);
                        },
                        items: userTypeKeys
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value).tr(), // Added translation here
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: JSizes.inputFieldRadius),

              TextFieldWidget(
                subTitle: 'password',
                hintText: '*****',
                subtitleColor:
                isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor:
                isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: validateRequired,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'passwordMustBe',
                style: AppTextStyle.dmSans(
                  color:
                  isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
                  fontSize: JSizes.fontSizeSm,
                  weight: FontWeight.w500,
                ),
              ).tr(),

              SizedBox(height: JSizes.inputFieldRadius),
              TextFieldWidget(
                subTitle: 'confirmPassword',
                hintText: '*****',
                subtitleColor:
                isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor:
                isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: validateRequired,
              ),

              const SizedBox(height: 25),

              MainButton(
                onTap: () {
                  // Pass the selected user type to the next screen or API call
                  print('Signing up as: $selectedUserType');
                  AppRouter.router.push('/companySignupScreen');
                },
                btn_title: 'next',
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