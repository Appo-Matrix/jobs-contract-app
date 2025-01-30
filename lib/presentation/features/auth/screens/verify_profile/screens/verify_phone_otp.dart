import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/verify_profile/screens/widgets/buildOtpBox.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import '../../../../../../utils/common_widgets/appbar.dart';
import '../../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/device/device_utility.dart';

class VerifyPhoneOtp extends StatefulWidget {
  const VerifyPhoneOtp({super.key});

  @override
  State<VerifyPhoneOtp> createState() => _VerifyPhoneOtpState();
}

class _VerifyPhoneOtpState extends State<VerifyPhoneOtp> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        title: Text(
          JText.verifyPhoneNumber,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 20,
          child: Icon(
            CupertinoIcons.back,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
          ),
        ),
      ),
      bottomNavigationBar: Padding(padding: EdgeInsets.symmetric(vertical: 26,horizontal: 16),child:               SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Verify OTP logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: JAppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            JText.next,
            style: AppTextStyle.dmSans(
              color: Colors.white,
              fontSize: 16.0,
              weight: FontWeight.w600,
            ),
          ),
        ),
      ),
          ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  JText.secureCode,
                  textAlign: TextAlign.start,
                  style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.lightGray100
                        : JAppColors.darkGray800,
                    fontSize: 16.0,
                    weight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // OTP Input Fields
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      List.generate(4, (index) => buildOtpBox(index, context)),
                ),
              ),

              SizedBox(height: JSizes.spaceBtwSections + 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    JText.receivecode,
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.lightGray500
                          : JAppColors.darkGray600,
                      fontSize: 16.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: JSizes.xs + 2,
                  ),
                  Text(
                    JText.sendAgain,
                    style: AppTextStyle.dmSans(
                      color: JAppColors.primary,
                      fontSize: 18.0,
                      weight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: JSizes.spaceBtwSections + 30),

              // Next Button
            ],
          ),
        ),
      ),
    );
  }
}
