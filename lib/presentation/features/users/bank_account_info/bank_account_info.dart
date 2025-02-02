import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/image_string.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_shape.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';

class BankAccountInfo extends StatefulWidget {
  const BankAccountInfo({super.key});

  @override
  State<BankAccountInfo> createState() => _BankAccountInfoState();
}

class _BankAccountInfoState extends State<BankAccountInfo> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        title:
        Text(
          JText.bankAccountInfo,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 20, // Modify the radius to make it larger
          child: Icon(
            CupertinoIcons.back,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
          ),
        ),
      ),

      body: Column(children: [


        SizedBox(height: 8,)
        ,          Container(height: 1,color: isDark ?  JAppColors.lightGray200 : JAppColors.grayBlue800,),



        Padding(
          padding: EdgeInsets.symmetric(vertical: 16 ,horizontal: 26),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
            height: 78,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800.withValues(alpha: 0.5), // Border color (transparent in this case)
                width: 1, // Border width
              ),
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            child:
            Row(
              children: [
                // Notification icon

                SizedBox(width: 12,height: 12,),
                Align(
                    alignment: Alignment.topCenter,
                    child: Image(image: AssetImage(JImages.notifications), height: 24, width: 24)),

                Spacer(), // Adds space between the image and the text

                // Column to stack text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start (left)
                  mainAxisAlignment: MainAxisAlignment.center, // Center vertically within the column
                  children: [
                    Text(
                      '34534fe23234243',
                      style: AppTextStyle.dmSans(
                        color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                        fontSize: 16.0,
                        weight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 8,),
                    Text(
                      'Basit Murad',
                      style: AppTextStyle.dmSans(
                        color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                        fontSize: 16.0,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                Spacer(), // Adds space between the text and the icon

                // Icon button on the right
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_vert_sharp),
                  ),
                ),
              ],
            ),
          ),
        )

      ],),


    );
  }
}
