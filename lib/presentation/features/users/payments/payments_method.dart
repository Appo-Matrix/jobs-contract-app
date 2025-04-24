import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/payments/widgets/dialoge_widget.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
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
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,

      appBar: JAppbar(
        title: Text(
          'paymentmethod',
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ).tr(),
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
                    'addPaymentMethod',
                    style: AppTextStyle.dmSans(
                      color: Colors.white,
                      fontSize: 16.0,
                      weight: FontWeight.w600,
                    ),
                  ).tr(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}



