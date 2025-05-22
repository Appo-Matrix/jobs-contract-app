import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/verify_profile/screens/widgets/buildOtpBox.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:pinput/pinput.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';

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
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: AppTextStyle.dmSans(
        color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
        fontSize: 24.0,
        weight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: isDark ? Colors.transparent : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray400,
          width: 1,
        ),
      ),
    );

    // Define focused theme
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(
          color: JAppColors.primary,
          width: 1.5,
        ),
      ),
    );
    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,



      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const SizedBox(height: 20),

              Image(height: 50, width: 50, image: AssetImage(JImages.appleLogo)),
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  JText.verify,
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
                          ? JAppColors.lightGray400
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
                      color: isDark
                          ? JAppColors.lightGray100
                          : JAppColors.primary,
                      fontSize: 18.0,
                      weight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: JSizes.spaceBtwSections + 30),


              MainButton(
                btn_title: JText.sendCode,
                btn_radius: 10,
                btn_color: JAppColors.main,
                btn_boarder_color: Color(0xff7030F1),
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                onTap: (){
                  AppRouter.router.push('/resetPasswordScreen');
                },
              ),


              // Next Button
            ],
          ),
        ),
      ),
    );
  }
}
