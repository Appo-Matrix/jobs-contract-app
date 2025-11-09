import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/verify_profile/screens/widgets/profile_verification_container.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import '../../../../../../utils/common_widgets/appbar.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../verification_help_dialog.dart';

class VerifyProfile extends StatefulWidget {
  const VerifyProfile({super.key});

  @override
  State<VerifyProfile> createState() => _VerifyProfileState();
}

class _VerifyProfileState extends State<VerifyProfile> {
  bool isCheckedPhoneNumber = false;
  bool isCheckedPaymentMethod = false;
  bool isCheckedIdentity = false;

  void _showPhoneVerificationHelp() {
    showDialog(
      context: context,
      builder: (_) => VerificationHelpDialog(
        title: "Phone Number Verification",
        description: "Verify your phone number to secure your account and enable two-factor authentication.",
        icon: Icons.phone_android,
        iconColor: JAppColors.primary,
        bulletPoints: [
          "Receive a verification code via SMS",
          "Enter the code to confirm your number",
          "Takes less than 2 minutes",
          "Enhances account security",
        ],
      ),
    );
  }

  void _showPaymentMethodHelp() {
    showDialog(
      context: context,
      builder: (_) => VerificationHelpDialog(
        title: "Payment Method Verification",
        description: "Add and verify your payment method to withdraw your earnings seamlessly.",
        icon: Icons.credit_card,
        iconColor: Colors.green,
        bulletPoints: [
          "Link your bank account or card",
          "Verify with a small test deposit",
          "Required for withdrawals",
          "All transactions are secure and encrypted",
        ],
      ),
    );
  }

  void _showIdentityVerificationHelp() {
    showDialog(
      context: context,
      builder: (_) => VerificationHelpDialog(
        title: "Identity Verification",
        description: "Complete identity verification to unlock all platform features and build trust.",
        icon: Icons.verified_user,
        iconColor: Colors.orange,
        bulletPoints: [
          "Upload a government-issued ID",
          "Take a quick selfie for verification",
          "Processing takes 3-4 business days",
          "Increases your profile credibility",
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        title: Text(
          JText.verifyProfile,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: const Icon(Icons.arrow_back),
        leadingOnPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              // Phone Number Verification
              ProfileVerificationContainer(
                isChecked: isCheckedPhoneNumber,
                isVerified: isCheckedPhoneNumber,
                onChanged: (value) {
                  setState(() {
                    isCheckedPhoneNumber = value!;
                  });
                },
                checkboxRadius: 12,
                title: JText.verifyPhoneNumber,
                description: JText.verifyPhoneNumberDesc,
                onHelpTap: _showPhoneVerificationHelp,
                onVerifyTap: () {
                  // Navigate to phone verification screen
                  AppRouter.router.push('/verifyPhoneNumber');
                },
              ),
              SizedBox(height: JSizes.md),

              // Payment Method Verification
              ProfileVerificationContainer(
                isChecked: isCheckedPaymentMethod,
                isVerified: isCheckedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    isCheckedPaymentMethod = value!;
                  });
                },
                checkboxRadius: 12,
                title: JText.verifyPaymentMethods,
                description: JText.verifyPhoneNumberDesc,
                onHelpTap: _showPaymentMethodHelp,
                onVerifyTap: () {
                  // Navigate to payment method verification screen
                  AppRouter.router.push('/verifyPaymentMethod');
                },
              ),
              SizedBox(height: JSizes.md),

              // Identity Verification
              ProfileVerificationContainer(
                isChecked: isCheckedIdentity,
                isVerified: isCheckedIdentity,
                onChanged: (value) {
                  setState(() {
                    isCheckedIdentity = value!;
                  });
                },
                checkboxRadius: 12,
                title: JText.verifyIdentity,
                description: JText.verifyIdentityDesc,
                onHelpTap: _showIdentityVerificationHelp,
                onVerifyTap: () {
                  // Navigate to identity verification screen
                  AppRouter.router.push('/verifyIdentity');
                },
              ),
              SizedBox(height: JSizes.spaceBtwSections + 20),
            ],
          ),
        ),
      ),
    );
  }
}