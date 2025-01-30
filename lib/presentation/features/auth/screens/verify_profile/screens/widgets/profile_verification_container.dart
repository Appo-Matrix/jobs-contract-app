import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import '../../../../../../../utils/common_widgets/circular_checkbox.dart';
import '../../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../../utils/constants/colors.dart';
import '../../../../../../../utils/constants/image_string.dart';
import '../../../../../../../utils/constants/sizes.dart';



class ProfileVerificationContainer extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;
  final double checkboxRadius;
  final String title;
  final String description;

  const ProfileVerificationContainer({
    Key? key,
    required this.isChecked,
    required this.onChanged,
    required this.checkboxRadius,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: JAppColors.lightGray300, // Use theme's divider color
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                JCircularCheckbox(
                  isChecked: isChecked,
                  onChanged: onChanged,
                  radius: checkboxRadius, // Size of the circular checkbox
                  borderColor: JAppColors.lightGray300,  // Border color for checkbox
                  fillColor: JAppColors.primary,  // Fill color when checked
                  checkColor: JAppColors.lightGray100,  // Color of the check mark
                ),
                SizedBox(width: JSizes.md),
                Text(
                  title,
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                    fontSize: 16.0,
                    weight: FontWeight.w400,
                  ),
                ),
                Spacer(), // Pushes the image to the end of the row

                GestureDetector(
                    onTap: (){},
                    child: Image(image: AssetImage(JImages.helpCircle ) ,height: 20,width: 20,))
              ],
            ),
            SizedBox(height: JSizes.spaceBtwInputFields - 3),

            Text(
              description,
              style: AppTextStyle.dmSans(
                color: isDark
                    ? JAppColors.darkGray100.withOpacity(0.5)
                    : JAppColors.lightGray800.withOpacity(0.5),
                fontSize: 16.0,
                weight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
