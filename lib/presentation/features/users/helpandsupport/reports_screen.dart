import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../routes/app_routes.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? selectedReason;
  final List<String> reasons = [
    'technicalIssue',
    'billingProblem',
    'accountAccess',
    'featureRequest',
    'generalInquiry',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    final height = JDeviceUtils.getScreenHeight(context);
    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          'contactSupport',
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ).tr(),
        leadingIcon: Icon(Icons.arrow_back),
        leadingOnPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: JSizes.spaceBtwSections - 20,
              ),
              Text(
                'reportReason',
                style: AppTextStyle.dmSans(
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  fontSize: 16.0,
                  weight: FontWeight.w600,
                ),
              ).tr(),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: isDark
                          ? JAppColors.darkGray700
                          : JAppColors.lightGray300,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: JAppColors.primary,
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  hintText: tr('selectReason'),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(right: 8), // Space after icon
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.lightGray700,
                  ),
                ),
                value: selectedReason,
                items: reasons.map((reason) {
                  return DropdownMenuItem<String>(
                    value: reason,
                    child: Text(
                      reason,
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.darkGray100
                            : JAppColors.lightGray900,
                        fontSize: 16.0,
                        weight: FontWeight.w400,
                      ),
                    ).tr(),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedReason = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                subTitle: 'reportsTitle',
                hintText: 'writeTitleHere',
                maxLines: 2,
                subtitleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                subTitle: 'reportDescription',
                hintText: 'whatYouWantToTalk',
                maxLines: 10,
                subtitleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              ),
              const SizedBox(height: 20),
              MainButton(
                btn_title: 'submit',
                btn_radius: 10,
                btn_color: JAppColors.main,
                btn_border_color: const Color(0xff7030F1),
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                onTap: () {
                  AppRouter.router.push('/navigationMenu');
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
