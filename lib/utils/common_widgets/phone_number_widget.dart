import 'package:flutter/material.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class PhoneNumberWidget extends StatelessWidget {


  const PhoneNumberWidget({
    super.key,

    // required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: JSizes.fontSizeMd,
            weight: FontWeight.w600,
          ),
        ),
         SizedBox(height: JSizes.spaceBtwInputFields),
        Container(
          height: 53,
          decoration: BoxDecoration(


            borderRadius: BorderRadius.all(Radius.circular(10),),
            border: Border.all(color: JAppColors.lightGray300, width: 1)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),git
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('1+', style: TextStyle(color: JAppColors.lightGray500, fontSize: 16),),
                SizedBox(width: 10),
                Image.asset('assets/icons/arrow_down_icon.png', height: 20,width: 20,),
                SizedBox(width: 10),
                Text('|', style: TextStyle(fontSize: 20, color: JAppColors.lightGray500),),
                SizedBox(width: 15),
                // TextField(
                //   decoration: InputDecoration(
                //     labelText: "Enter your name",
                //     border: OutlineInputBorder(),
                //   ),
                // ),

              ],

            ),
          ),
        )

      ],
    );
  }
}
