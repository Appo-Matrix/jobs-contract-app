import 'package:flutter/material.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/bottom_widget.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';
import 'package:pinput/pinput.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgetPasswordOtpScreen extends StatefulWidget {
  const ForgetPasswordOtpScreen({super.key});

  @override
  State<ForgetPasswordOtpScreen> createState() => _ForgetPasswordOtpScreenState();
}

class _ForgetPasswordOtpScreenState extends State<ForgetPasswordOtpScreen> {
  final TextEditingController otpController = TextEditingController();
  final List<TextEditingController> otpControllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String getEnteredOtp() {
    String otp = "";
    for (var controller in otpControllers) {
      otp += controller.text.trim();
    }
    return otp;
  }

  Widget buildOtpBox(int index, BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Container(
      width: 64,
      height: 75,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: otpControllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: AppTextStyle.dmSans(
          color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
          fontSize: 24.0,
          weight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: isDark ? Colors.transparent : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray400,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: JAppColors.primary,
              width: 1.5,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
          }
        },
      ),
    );
  }
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
        leadingIcon: Padding(
          padding: const EdgeInsets.all(2.0),
          child: BackCircle(
            isDark: isDark,
            onTap: (){
              Navigator.pop(context);
            },
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
                    color:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                    fontSize: 16.0,
                    weight: FontWeight.w500,
                  ),
                ).tr(),
              ),
              const SizedBox(height: 20),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                        (index) => buildOtpBox(index, context),
                  ),
                ),
              ),
              SizedBox(height: JSizes.spaceBtwSections ),


              MainButton(
                btn_title: 'verifyEmail',
                btn_radius: 10,
                btn_color: JAppColors.primary,
                btn_boarder_color: const Color(0xff7030F1),
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                onTap: () {
                  final otp = getEnteredOtp();
                  if (otp.length == 4) {
                    print("Entered OTP is: $otp");
                    AppRouter.router.push('/navigationMenu');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter complete OTP')),
                    );
                  }
                },
                isDark: isDark,
              ),

              SizedBox(height: JSizes.spaceBtwSections ),

              BottomWidget(
                isDark: isDark,
                title: 'receiveCode',
                titleDes: 'sendAgain',
                onPressed: () {
                  // Handle resend OTP
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
