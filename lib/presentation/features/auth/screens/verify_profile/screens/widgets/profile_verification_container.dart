
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
  final bool? isVerified;
  final VoidCallback? onHelpTap; // <-- New callback property

  const ProfileVerificationContainer({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.checkboxRadius,
    required this.title,
    required this.description,
    this.isVerified = false,
    this.onHelpTap, // optional
  });

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: JAppColors.lightGray300,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                JCircularCheckbox(
                  isChecked: isChecked,
                  onChanged: onChanged,
                  radius: checkboxRadius,
                  borderColor: JAppColors.lightGray300,
                  fillColor: JAppColors.primary,
                  checkColor: JAppColors.lightGray100,
                ),
                SizedBox(width: JSizes.md),
                Text(
                  title,
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                    fontSize: 14.0,
                    weight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                if (isVerified == true)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: JAppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Verified',
                      style: AppTextStyle.dmSans(
                        fontSize: 12.0,
                        weight: FontWeight.w600,
                        color: JAppColors.primary,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onHelpTap, // <-- Pass the callback here
                  child: Image(
                    image: AssetImage(JImages.helpCircle),
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
            SizedBox(height: JSizes.spaceBtwInputFields - 3),
            Text(
              description,
              style: AppTextStyle.dmSans(
                color: isDark
                    ? JAppColors.darkGray100.withOpacity(0.5)
                    : JAppColors.lightGray800.withOpacity(0.5),
                fontSize: 14.0,
                weight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
