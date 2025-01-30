import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/common_widgets/appbar.dart';
import '../../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/device/device_utility.dart';

class VerifyPaymentMethod extends StatefulWidget {
  const VerifyPaymentMethod({super.key});

  @override
  State<VerifyPaymentMethod> createState() => _VerifyPaymentMethodState();
}

class _VerifyPaymentMethodState extends State<VerifyPaymentMethod> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        title: Text(
          JText.verifyPaymentMethod,
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
      bottomNavigationBar:               Padding(
        padding: const EdgeInsets.symmetric(vertical: 26,horizontal: 16),
        child: SizedBox(
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
              JText.verifyPaymentMethod,
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
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                JText.paymentDetails,
                style: AppTextStyle.dmSans(
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 20.0,
                  weight: FontWeight.w600,
                ),
              ),
              SizedBox(height: JSizes.spaceBtwSections ),
              TextFieldWidget(
                hintText: 'Basit Murad',
                subTitle: JText.accountName,
                subtitleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray700,
              ),

              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                hintText: '9348534',
                subTitle: JText.accountNo,
                subtitleColor:
                isDark ? JAppColors.lightGray100 : JAppColors.darkGray700,
              ),


              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                hintText: '10/12/2025',
                subTitle: JText.expiraryDate,
                subtitleColor:
                isDark ? JAppColors.lightGray100 : JAppColors.darkGray700,
              ),

              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                hintText: '0023',
                subTitle: JText.cVV,
                subtitleColor:
                isDark ? JAppColors.lightGray100 : JAppColors.darkGray700,
              ),

              SizedBox(height: JSizes.spaceBtwSections + 80),


            ],
          ),
        ),
      ),
    );
  }
}
