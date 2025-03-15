import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/payments/widgets/dialoge_widget.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_shape.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';

class PaymentsMethod extends StatefulWidget {
  const PaymentsMethod({super.key});

  @override
  State<PaymentsMethod> createState() => _PaymentsMethodState();
}

class _PaymentsMethodState extends State<PaymentsMethod> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,

      appBar: JAppbar(
        title: Text(
          JText.paymentmethod,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 20,
          child: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.back,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align left
            children: [

              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: JDialogWidget(isDark: isDark),
              ),


              SizedBox(height: JSizes.spaceBtwSections,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: JAppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    JText.addPaymentMethod,
                    style: AppTextStyle.dmSans(
                      color: Colors.white,
                      fontSize: 16.0,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}



