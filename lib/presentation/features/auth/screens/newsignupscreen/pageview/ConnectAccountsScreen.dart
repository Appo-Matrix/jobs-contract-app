import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/common_widgets/main_button.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_string.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';


class ConnectAccountsScreen extends StatefulWidget {
  final VoidCallback onContinue;
  final VoidCallback onBack;

  const ConnectAccountsScreen({
    super.key,
    required this.onContinue,
    required this.onBack, required void Function() onConnectAccount,
  });

  @override
  State<ConnectAccountsScreen> createState() => _ConnectAccountsScreenState();
}

class _ConnectAccountsScreenState extends State<ConnectAccountsScreen> {
  bool _isConnectingGoogle = false;
  bool _isConnectingFacebook = false;
  bool _isConnectingApple = false;

  void _handleGoogleConnect() async {
    setState(() => _isConnectingGoogle = true);

    // Simulate Google authentication
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() => _isConnectingGoogle = false);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('googleConnectedSuccess'.tr()),
        backgroundColor: JAppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    // Wait a moment then proceed
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    widget.onContinue();
  }

  void _handleFacebookConnect() async {
    setState(() => _isConnectingFacebook = true);

    // Simulate Facebook authentication
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() => _isConnectingFacebook = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('facebookConnectedSuccess'.tr()),
        backgroundColor: JAppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    widget.onContinue();
  }

  void _handleAppleConnect() async {
    setState(() => _isConnectingApple = true);

    // Simulate Apple authentication
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() => _isConnectingApple = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('appleConnectedSuccess'.tr()),
        backgroundColor: JAppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    widget.onContinue();
  }

  void _handleContinueWithout() {
    widget.onContinue();
  }

  bool get _isAnyConnecting =>
      _isConnectingGoogle || _isConnectingFacebook || _isConnectingApple;

  @override
  Widget build(BuildContext context) {
    final bool isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkBackground : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'connectAccounts',
                style: AppTextStyle.dmSans(
                  fontSize: 26.0,
                  weight: FontWeight.w700,
                  color: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray900,
                ),
              ).tr(),
              const SizedBox(height: 8),
              Text(
                'connectAccountsSubtitle',
                style: AppTextStyle.dmSans(
                  fontSize: 15.0,
                  color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.darkGray500,
                  weight: FontWeight.w400,
                ),
              ).tr(),

              const SizedBox(height: 40),

              MainButton(
                btn_image: JImages.googleImage,

                height: 52,
                btn_title: "Use Google",
                btn_radius: 10,
                title_color:
                isDark ? JAppColors.darkGray100 : JAppColors.lightGray100,
                text_fontweight: FontWeight.w600,
                image_value: true,
                onTap: () {},
                text_size: JSizes.fontSizeMd,
              ),


              const SizedBox(height: 16),


              const SizedBox(height: 30),

              // OR Divider
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: isDark ? JAppColors.darkGray300 : Colors.grey[300],
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or'.tr(),
                      style: AppTextStyle.dmSans(
                        fontSize: 14.0,
                        color: isDark
                            ? JAppColors.darkGray100
                            : JAppColors.darkGray500,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: isDark ? JAppColors.darkGray300 : Colors.grey[300],
                      thickness: 1,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Continue Without Button
              MainButton(
                onTap: _isAnyConnecting ? null : _handleContinueWithout,
                btn_color: _isAnyConnecting
                    ? (isDark ? JAppColors.darkGray300 : JAppColors.darkGray200)
                    : JAppColors.primary,
                btn_title: 'continueWithoutAccounts',
                btn_radius: 12,

                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                isDark: isDark,
              ),

              const Spacer(),

              // Back Button
              Center(
                child: TextButton.icon(
                  onPressed: _isAnyConnecting ? null : widget.onBack,
                  icon: Icon(
                    Icons.arrow_back,
                    color: _isAnyConnecting
                        ? (isDark ? JAppColors.darkGray300 : Colors.grey)
                        : JAppColors.primary,
                    size: 20,
                  ),
                  label: Text(
                    'back'.tr(),
                    style: AppTextStyle.dmSans(
                      fontSize: 15.0,
                      color: _isAnyConnecting
                          ? (isDark ? JAppColors.darkGray300 : Colors.grey)
                          : JAppColors.primary,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// Social Login Button Widget
