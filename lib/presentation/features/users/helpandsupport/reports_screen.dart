import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/common_widgets/main_button.dart';
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: InputBorder.none,
                    hintText: tr('selectReason'),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down),
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
              ),
              const SizedBox(height: 20),
              Text(
                'reportsTitle',
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 16.0,
                  weight: FontWeight.w600,
                ),
              ).tr(),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: tr('writeTitleHere'),
                    hintStyle: AppTextStyle.dmSans(
                      color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                      fontSize: 14.0,
                      weight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'reportDescription',
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 16.0,
                  weight: FontWeight.w600,
                ),
              ).tr(),
              const SizedBox(height: 8),
              Container(
                height: height / 2.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isDark ? Colors.transparent : Colors.transparent,
                  border: Border.all(
                    color: Colors.grey[300]!, // Customize border color
                    width: 1.5, // Border thickness
                  ),
                ),
                child: TextField(
                  maxLines: 5,
                  minLines: 5,
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                    fontSize: 16.0,
                    weight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: tr('whatYouWantToTalk'),
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              MainButton(
                btn_title: 'submit',
                btn_radius: 10,
                btn_color: JAppColors.main,
                btn_boarder_color: const Color(0xff7030F1),
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