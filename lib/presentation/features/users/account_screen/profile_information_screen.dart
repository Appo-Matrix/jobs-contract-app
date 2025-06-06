import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:job_contracts/utils/common_widgets/main_button.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../utils/common_widgets/circular_progess_loader.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() => _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  bool _isLoading = false;

  void _handleSave() async {
    setState(() {
      _isLoading = true;
    });

    showProgressDialog(context);

    // Simulate saving or perform your save logic
    await Future.delayed(Duration(seconds: 5));

    Navigator.pop(context); // Close the loading dialog

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile saved successfully".tr())),
    );
  }

  void showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (_) => const Center(
        child: FancyCircularLoader(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          'profileInfo',
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.w600,
          ),
        ).tr(),
        leadingIcon: Padding(
          padding: const EdgeInsets.all(2.0),
          child: BackCircle(
            isDark: isDark,
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: 'firstName',
                hintText: 'e.g john'.tr(),
                subtitleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: 'lastName',
                hintText: 'e.g doe'.tr(),
                subtitleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: 'dateOfBirth',
                hintText: '10 August 2004'.tr(),
                subtitleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                suffixIcon: Icon(Icons.calendar_month_outlined),
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                subTitle: 'emailAddress',
                hintText: 'e.g johndev@gmail.com',
                subtitleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),

              Text(
                'phone',
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.lightGray100 : JAppColors.lightGray800,
                  fontSize: JSizes.fontSizeMd,
                  weight: FontWeight.w600,
                ),
              ).tr(),
              SizedBox(height: JSizes.spaceBtwInputFields - 8),
              IntlPhoneField(
                decoration: InputDecoration(
                  fillColor: isDark ? JAppColors.backGroundDarkCard : Colors.transparent,
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide()),
                ),
                initialCountryCode: 'PK',
                onChanged: (phone) {
                  print('Complete phone number: ${phone.completeNumber}');
                },
                onCountryChanged: (country) {
                  print('Country changed to: ${country.name}');
                },
              ),
              SizedBox(height: JSizes.spaceBtwInputFields + 25),
              MainButton(
                onTap: _isLoading ? null : _handleSave,
                btn_title: 'save'.tr(),
                btn_radius: 10,
                btn_color: JAppColors.main,
                btn_boarder_color: Colors.transparent,
                title_color: Colors.white,
                image_value: false,
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
