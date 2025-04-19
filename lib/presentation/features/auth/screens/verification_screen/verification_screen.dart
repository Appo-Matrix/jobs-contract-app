import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/verification_screen/widgets/verify_header.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/image_string.dart';

import '../../../../../utils/common_widgets/appbar2.dart';
import '../../../../../utils/common_widgets/option_card.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isEmailVerified = false;

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final backgroundColor = isDark ? JAppColors.backGroundDark : Colors.white;

    Future<void> _navigateToEmailOtp() async {
      final result = await AppRouter.router.push('/checkEmailScreen');
      if (result == true) {
        setState(() {
          isEmailVerified = true;
        });
      }
    }

    void _navigateToPhoneOtp() {
      if (isEmailVerified) {
        AppRouter.router.push('/checkPhoneScreen');
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: JAppBar2(title: JText.back),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                VerifyHeader(isDark: isDark),
                const SizedBox(height: 40),

                // Email & Phone Verification Options
                Row(
                  children: [
                    Expanded(
                      child: OptionCard(
                        height: 140,
                        width: 140,
                        title: JText.email,
                        svgPath: JImages.emailsvg,
                        iconSize: 30,
                        onTap: _navigateToEmailOtp,
                      ),
                    ),
                    const SizedBox(width: 19),
                    Expanded(
                      child: Opacity(
                        opacity: isEmailVerified ? 1.0 : 0.4,
                        child: IgnorePointer(
                          ignoring: !isEmailVerified,
                          child: OptionCard(
                            height: 140,
                            width: 140,
                            title: JText.phone,
                            svgPath: JImages.phonesvg,
                            iconSize: 30,
                            onTap: _navigateToPhoneOtp,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
