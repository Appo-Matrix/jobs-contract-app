import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';

class MembershipPlanCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isCurrentPlan;
  final List<String> features;
  final String buttonText;
  final bool isPurple;
  final VoidCallback? onTap;

  const MembershipPlanCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.isCurrentPlan = false,
    required this.features,
    required this.buttonText,
    required this.isPurple,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final Color cardColor = isPurple
        ? const Color(0xFF7030F1)
        : (isDark ? JAppColors.darkGray800 : Colors.white);
    final Color textColor = isPurple
        ? Colors.white
        : (isDark ? JAppColors.darkGray100 : Colors.black);
    final Color checkColor = isPurple
        ? Colors.white
        : const Color(0xFF4CAF50);
    final Color borderColor = isDark ? JAppColors.darkGray600 : Colors.grey.shade300;
    final Color subtitleColor = isPurple
        ? Colors.white70
        : (isDark ? Colors.purpleAccent.withOpacity(0.7) : Colors.purple);

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: isPurple
            ? null
            : Border.all(color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ).tr(),
                if (isCurrentPlan)
                  Text(
                    'yourCurrentPlan',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                    ),
                  ).tr(),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                color: subtitleColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ).tr(),
            const SizedBox(height: 16),
            Text(
              'includes',
              style: TextStyle(
                color: textColor,
                fontSize: 14,
              ),
            ).tr(),
            const SizedBox(height: 12),

            // Features with checkmarks
            ...features.map((feature) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    color: checkColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                      ),
                    ).tr(),
                  ),
                ],
              ),
            )),

            if (buttonText.isNotEmpty) ...[
              const SizedBox(height: 20),
              MainButton(
                btn_title: buttonText,
                btn_radius: 10,
                btn_color: isPurple
                    ? Colors.white
                    : JAppColors.main,
                btn_border_color: const Color(0xff7030F1),
                title_color: isPurple
                    ? const Color(0xFF7030F1)
                    : Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                onTap: onTap ?? () {},
              ),
            ],
          ],
        ),
      ),
    );
  }
}