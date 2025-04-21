import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/common_widgets/appbar2.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';



class EmailVerifiedScreen extends StatefulWidget {
  const EmailVerifiedScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerifiedScreen> createState() => _EmailVerifiedScreenState();
}

class _EmailVerifiedScreenState extends State<EmailVerifiedScreen> {
  // Selected notification preferences
  final List<String> _selectedNotifications = [];

  @override
  void initState() {
    super.initState();
    // Show notification settings dialog after a short delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showNotificationSettingsDialog();
    });
  }

  void _showNotificationSettingsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return NotificationSettingsDialog(
          onSubmit: (selectedOptions) {
            setState(() {
              _selectedNotifications.clear();
              _selectedNotifications.addAll(selectedOptions);
            });
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final isDark = JDeviceUtils.isDarkMode(context);
    final backgroundColor = isDark ? JAppColors.backGroundDark : Colors.white;

    final secondaryTextColor = isDark ? Colors.white70 : Colors.black54;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: JAppBar2(title: JText.back),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                JText.emailVerified,
                style: AppTextStyle.dmSans(
                  color: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                  fontSize: 24.0,
                  weight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                JText.verificationMessage,
                style: AppTextStyle.dmSans(
                  color: isDark
                      ? JAppColors.lightGray500
                      : JAppColors.darkGray500,
                  fontSize: 16.0,
                  weight: FontWeight.w400,
                ),
              ),

              // Display selected notification preferences or other content here
            ],
          ),
        ),
      ),
    );
  }
}

// Notification Settings Dialog
class NotificationSettingsDialog extends StatefulWidget {
  final Function(List<String>) onSubmit;

  const NotificationSettingsDialog({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<NotificationSettingsDialog> createState() => _NotificationSettingsDialogState();
}

class _NotificationSettingsDialogState extends State<NotificationSettingsDialog> {
  final List<String> _notificationOptions = [
    JText.newJobOpportunities,
    JText.promotionsDiscounts,
    JText.industryNews,
  ];

  final List<String> _selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    final bool isDark= JDeviceUtils.isDarkMode(context);
    return Dialog(
      backgroundColor: isDark ? JAppColors.lightGray800 :Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  JText.notificationSettings,
                  style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.lightGray100
                        : JAppColors.darkGray500,
                    fontSize: 16.0,
                    weight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              JText.notificationPreference,
              style: AppTextStyle.dmSans(
                color: isDark
                    ? JAppColors.lightGray100
                    : JAppColors.darkGray500,
                fontSize: 14.0,
                weight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),

            // Notification options
            ...List.generate(
              _notificationOptions.length,
                  (index) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: _buildNotificationOption(_notificationOptions[index]),
              ),
            ),

            const SizedBox(height: 16),


            MainButton(
              btn_title: JText.submit,
              btn_radius: 10,
              btn_color: JAppColors.main,
              btn_boarder_color: Color(0xff7030F1),
              title_color: Colors.white,
              text_fontweight: FontWeight.w600,
              image_value: false,
              onTap: (){
                widget.onSubmit(_selectedOptions);

                AppRouter.router.push('/navigationMenu');
              },
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildNotificationOption(String option) {
    final bool isSelected = _selectedOptions.contains(option);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedOptions.remove(option);
          } else {
            _selectedOptions.add(option);
          }
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: const Color(0xFF6C38FF), width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            option,
            style: TextStyle(
              color: isSelected ? const Color(0xFF6C38FF) : Colors.black,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

// Check Email Screen
