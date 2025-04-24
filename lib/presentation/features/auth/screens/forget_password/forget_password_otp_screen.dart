import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';
import '../verify_profile/screens/widgets/buildOtpBox.dart';
import 'package:pinput/pinput.dart';
class ForgetPasswordOtpScreen extends StatefulWidget {
  const ForgetPasswordOtpScreen({super.key});

  @override
  State<ForgetPasswordOtpScreen> createState() => _ForgetPasswordOtpScreenState();
}

class _ForgetPasswordOtpScreenState extends State<ForgetPasswordOtpScreen> {
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
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,

      appBar: JAppbar(
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: Padding(padding: EdgeInsets.symmetric(vertical: 26,horizontal: 16),child:               SizedBox(
        width: double.infinity,
        child:
        MainButton(
          btn_title: 'verify',
          btn_radius: 10,
          btn_color: JAppColors.primary,

          btn_boarder_color: Color(0xff7030F1),
          title_color: Colors.white,
          text_fontweight: FontWeight.w600,
          image_value: false,
          onTap: (){
            AppRouter.router.push('/resetPasswordScreen');




          }, isDark: isDark,
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
                  'secureCode',
                  textAlign: TextAlign.start,
                  style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.lightGray100
                        : JAppColors.darkGray800,
                    fontSize: 16.0,
                    weight: FontWeight.w500,
                  ),
                ).tr(),
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
                  Expanded(
                    child: Text(
                      'receivecode',
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.lightGray400
                            : JAppColors.darkGray600,
                        fontSize: 16.0,
                        weight: FontWeight.w400,
                      ),
                    ).tr(),
                  ),
                  SizedBox(
                    width: JSizes.xs + 2,
                  ),
                  Expanded(
                    child: Text(
                      'sendAgain',
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.lightGray100
                            : JAppColors.primary,
                        fontSize: 18.0,
                        weight: FontWeight.w600,
                      ),
                    ).tr(),
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
