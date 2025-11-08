import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../routes/app_routes.dart';

class CompanySignupScreen extends StatefulWidget {
  const CompanySignupScreen({super.key});

  @override
  State<CompanySignupScreen> createState() => _CompanySignupScreenState();
}

class _CompanySignupScreenState extends State<CompanySignupScreen> {
  final TextEditingController _licenseNumberController =
      TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  File? _selectedImage;
  bool _acceptTerms = false;
  String? _selectedCountry;
  String? _selectedBusinessType;
  String? _selectedExperienceRange;

  // Translation keys for business types
  final List<String> _businessTypeKeys = [
    'businessTypes.generalConstruction',
    'businessTypes.residentialConstruction',
    'businessTypes.commercialConstruction',
    'businessTypes.realEstateDevelopment',
    'businessTypes.propertyManagement',
    'businessTypes.architectureFirm',
    'businessTypes.engineeringFirm',
    'businessTypes.renovationRemodeling',
    'businessTypes.roofingSiding',
    'businessTypes.plumbingServices',
    'businessTypes.electricalServices',
    'businessTypes.hvacServices',
    'businessTypes.landscapingOutdoor',
    'businessTypes.interiorDesign',
    'businessTypes.realEstateAgency',
    'businessTypes.propertyInvestment',
    'businessTypes.constructionMaterials',
    'businessTypes.heavyEquipmentRental',
    'businessTypes.inspectionServices',
    'businessTypes.other'
  ];

  // Translation keys for experience ranges
  final List<String> _experienceRangeKeys = [
    'experienceRanges.oneToThree',
    'experienceRanges.fourToSeven',
    'experienceRanges.eightToFifteen',
    'experienceRanges.sixteenToTwentyFive',
    'experienceRanges.twentyFivePlus'
  ];

  // Translation keys for countries
  final List<String> _countryKeys = [
    'countries.unitedStates',
    'countries.canada',
    'countries.unitedKingdom',
    'countries.australia',
    'countries.germany',
    'countries.france',
    'countries.spain',
    'countries.italy',
    'countries.mexico',
    'countries.brazil'
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = JDeviceUtils.isDarkMode(context);
    return Scaffold(
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
              'signUpAsCompany',
              style: AppTextStyle.dmSans(
                color: isDark ? Colors.white : JAppColors.darkGray800,
                fontSize: 18.0,
                weight: FontWeight.w600,
              ),
            ).tr(),
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

            // Business Type Dropdown
            Text(
              'businessType',
              style: AppTextStyle.dmSans(
                color:  isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w500,
              )).tr(),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedBusinessType,
              hint: Text(
                'businessTypeHint',
                style: AppTextStyle.dmSans(
                  color: isDark ? Colors.white : JAppColors.darkGray800,
                  fontSize: 10.0,
                  weight: FontWeight.w400,
                ),
              ).tr(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF7C3AED)),
                ),
              ),
              items: _businessTypeKeys.map((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(key , style: AppTextStyle.dmSans(
                    color: isDark ? Colors.white : JAppColors.darkGray800,
                    fontSize: 14.0,
                    weight: FontWeight.w400,
                  ),).tr(),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBusinessType = newValue;
                });
              },
            ),
            SizedBox(height: JSizes.inputFieldRadius),

            // Country Dropdown
            Text(
              'country',
              style: AppTextStyle.dmSans(
                color:  isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w500,
              ),
            ).tr(),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedCountry,
              hint: Text('countryHint', style: AppTextStyle.dmSans(
                color: isDark ? Colors.white : JAppColors.darkGray800,
                fontSize: 16.0,
                weight: FontWeight.w400,
              ),).tr(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF7C3AED)),
                ),
              ),
              items: _countryKeys.map((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(key, style: AppTextStyle.dmSans(
                    color: isDark ? Colors.white : JAppColors.darkGray800,
                    fontSize: 14.0,
                    weight: FontWeight.w400,
                  ),).tr(),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCountry = newValue;
                });
              },
            ),
            SizedBox(height: JSizes.inputFieldRadius),


            TextFieldWidget(
              subTitle: 'licenseNumber',
              hintText: '654642343',
              subtitleColor:
              isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              titleColor:
              isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              isRequired: true,
            ),

            SizedBox(height: JSizes.inputFieldRadius),

            // Years of Experience
            Text(
              'yearsOfExperience',
              style: AppTextStyle.dmSans(
                color:  isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w500,
              ) ).tr(),

            SizedBox(height: 8,),
            DropdownButtonFormField<String>(
              value: _selectedExperienceRange,
              hint: Text('experienceHint' ,style: AppTextStyle.dmSans(
                color:  isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w500,
              )).tr(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF7C3AED)),
                ),
              ),
              items: _experienceRangeKeys.map((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(key, style: AppTextStyle.dmSans(
                    color: isDark ? Colors.white : JAppColors.darkGray800,
                    fontSize: 14.0,
                    weight: FontWeight.w400,
                  ),).tr(),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedExperienceRange = newValue;
                });
              },
            ),
            SizedBox(height: JSizes.inputFieldRadius),

            TextFieldWidget(
              textEditingController: _websiteController,
              subTitle: 'companyWebsite',
              hintText: 'emailEnter',
              subtitleColor:
                  isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              titleColor:
                  isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              isRequired: true,
            ),
            SizedBox(height: JSizes.inputFieldRadius+10),


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
