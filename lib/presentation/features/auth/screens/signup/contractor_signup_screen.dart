import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import '../../../../../utils/common_widgets/international_phone_widget.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../routes/app_routes.dart';

class ContractorSignupScreen extends StatefulWidget {
  const ContractorSignupScreen({super.key});

  @override
  State<ContractorSignupScreen> createState() => _ContractorSignupScreenState();
}

class _ContractorSignupScreenState extends State<ContractorSignupScreen> {
  final TextEditingController _licenseNumberController =
  TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  File? _selectedImage;
  bool _acceptTerms = false;
  CountryCode? selectedCountry;
  String fullPhoneNumber = '';

  @override
  Widget build(BuildContext context) {
    final bool isDark = JDeviceUtils.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Logo Section

            Image(height: 50, width: 50, image: AssetImage(JImages.appleLogo)),
            const SizedBox(height: 20),

            // Title
            Text(
              'Sign Up As Contractor',
              style: AppTextStyle.dmSans(
                color: isDark ? Colors.white : JAppColors.darkGray800,
                fontSize: 18.0,
                weight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),

            // Upload Company Logo Section
            Center(
              child: GestureDetector(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: _selectedImage != null
                      ? ClipOval(
                    child: Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    ),
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_upload_outlined,
                        size: 30,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        textAlign: TextAlign.center,
                        'uploadCompanyLogo',
                        style: AppTextStyle.dmSans(
                          color: isDark
                              ? JAppColors.lightGray100
                              : JAppColors.darkGray800,
                          fontSize: 12.0,
                          weight: FontWeight.w400,
                        ),
                      ).tr(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            InternationalPhoneWidget(
              title: 'phone',
              hintText: 'enterPhoneNumber'.tr(),
              isRequired: true,
              initialCountryCode: 'PK',
              onChanged: (phone) {
                setState(() {
                  fullPhoneNumber = phone;
                });
                print('Phone Number: $phone');
              },
            ),



            TextFieldWidget(
              subTitle: 'address',
              hintText: 'enterHere',
              subtitleColor:
              isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              titleColor:
              isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              isRequired: true,
            ),

            SizedBox(height: JSizes.inputFieldRadius),

            TextFieldWidget(
              textEditingController: _websiteController,
              subTitle: 'country',
              hintText: 'countryHint',
              subtitleColor:
              isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              titleColor:
              isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              isRequired: true,
            ),

            SizedBox(height: JSizes.inputFieldRadius),

            TextFieldWidget(
              textEditingController: _websiteController,
              subTitle: 'preferredServiceType',
              hintText: 'enterHere',
              subtitleColor:
              isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              titleColor:
              isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              isRequired: true,
            ),
            SizedBox(height: JSizes.inputFieldRadius+15),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _acceptTerms = !_acceptTerms;
                    });
                  },
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _acceptTerms
                            ? const Color(0xFF7C3AED)
                            : (isDark ? Colors.grey.shade600 : Colors.grey.shade400),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4),
                      color: _acceptTerms
                          ? const Color(0xFF7C3AED)
                          : Colors.transparent,
                    ),
                    child: _acceptTerms
                        ? const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                        : null,
                  ),
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'I accept ',
                          style: AppTextStyle.dmSans(
                            color: isDark ? Colors.white : JAppColors.darkGray800,
                            fontSize: 14.0,
                            weight: FontWeight.w400,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              // Handle Terms & Conditions click
                              print('Terms & Conditions clicked');
                              // You can navigate to terms page or show dialog here
                            },
                            child: Text(
                              'Terms & Conditions',
                              style: AppTextStyle.dmSans(
                                color: const Color(0xFF7C3AED),
                                fontSize: 14.0,
                                weight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),


            MainButton(
              onTap: () {
                // Pass the selected user type to the next screen or API call
                AppRouter.router.push('/emailVerificationScreen');
              },
              btn_title: 'signUp',
              btn_radius: 10,
              btn_color: JAppColors.main,
              btn_boarder_color: Color(0xff7030F1),
              title_color: Colors.white,
              text_fontweight: FontWeight.w600,
              image_value: false,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _licenseNumberController.dispose();
    _websiteController.dispose();
    super.dispose();
  }
}
