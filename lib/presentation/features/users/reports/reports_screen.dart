import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/sizes.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_shape.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
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
    'Technical Issue',
    'Billing Problem',
    'Account Access',
    'Feature Request',
    'General Inquiry',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    final height = JDeviceUtils.getScreenHeight(context);
    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.contactSupport,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.back,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            ),
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
                JText.reportReason,
                style: AppTextStyle.dmSans(
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  fontSize: 16.0,
                  weight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: InputBorder.none,
                    hintText: 'Select Reason',
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
                      ),
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
                JText.reportsTitle,
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 16.0,
                  weight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child:  TextField(
                  decoration: InputDecoration(
                    hintText: 'Write the Title here',
                    hintStyle: AppTextStyle.dmSans(
                      color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                      fontSize: 16.0,
                      weight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
               Text(
                'Reports Description',
                 style: AppTextStyle.dmSans(
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                fontSize: 16.0,
                weight: FontWeight.w600,
              ),
              ),
              const SizedBox(height: 8),
              Container(
                height: height/2.5,

                // Height for approximately 5 lines of text
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray100, // Very light background color
                  // No border set here to hide it
                ),
                child: TextField(
                  maxLines: 5, // Setting exactly 5 lines
                  minLines: 5,

                  // Ensures the field keeps a 5-line height
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                    fontSize: 16.0,
                    weight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: 'What do you want to talk about?',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none, // Hides the default underline
                    enabledBorder: InputBorder.none, // Ensures border is hidden when enabled
                    focusedBorder: InputBorder.none, // Ensures border is hidden when focused
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              MainButton(
                btn_title: JText.submit,
                btn_radius: 10,
                btn_color: JAppColors.main,
                btn_boarder_color: Color(0xff7030F1),
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,onTap: (){
        
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
