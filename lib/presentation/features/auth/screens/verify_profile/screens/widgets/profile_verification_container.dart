import 'package:flutter/material.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import '../../../../../../../utils/common_widgets/circular_checkbox.dart';
import '../../../../../../../utils/common_widgets/main_button.dart';
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
  final VoidCallback? onHelpTap;
  final VoidCallback? onVerifyTap; // <-- New callback for verification button

  const ProfileVerificationContainer({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.checkboxRadius,
    required this.title,
    required this.description,
    this.isVerified = false,
    this.onHelpTap,
    this.onVerifyTap, // <-- Add this
  });

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Container(
      width: double.infinity,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row with Checkbox, Title, Verified Badge, and Help Icon
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
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray900,
                      fontSize: 14.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),
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
                  onTap: onHelpTap,
                  child: Image(
                    image: AssetImage(JImages.helpCircle),
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),

            SizedBox(height: JSizes.spaceBtwInputFields - 3),

            // Description Text
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                description,
                style: AppTextStyle.dmSans(
                  color: isDark
                      ? JAppColors.darkGray100.withOpacity(0.5)
                      : JAppColors.lightGray800.withOpacity(0.5),
                  fontSize: 14.0,
                  weight: FontWeight.w400,
                ),
              ),
            ),

            SizedBox(height: JSizes.spaceBtwInputFields),

            // Verify Button (Only show if not verified)
            if (isVerified == false && onVerifyTap != null)

              MainButton(
                btn_title: 'Verify Now',
                btn_radius: 6,
                height: 42,
                text_size: 14.0,

                buttonType: MainButtonType.outlined,

                title_color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800.withValues(alpha: 0.5),
                btn_border_color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800.withValues(alpha: 0.3),
                text_fontweight: FontWeight.w400,
                image_value: false,
                onTap: onVerifyTap,
              ),

          ],
        ),
      ),
    );
  }
}