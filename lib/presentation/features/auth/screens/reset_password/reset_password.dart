import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/colors.dart';

import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {


    final isDark = JDeviceUtils.isDarkMode(context);


    return Scaffold(
    backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      appBar: JAppbar(

        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 20,
          child: IconButton(onPressed: () {  },
                  
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900, icon: Icon(   CupertinoIcons.back,),
            
 
          ),
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
        // Proper spacing
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              JText.resetPassword,
              style: AppTextStyle.dmSans(
                color: isDark
                    ? JAppColors.darkGray200
                    : JAppColors.lightGray900,
                fontSize: 24.0,
                weight: FontWeight.w600,
              ),),

            SizedBox(height: JSizes.spaceBtwItems -6,),

            Text(
              JText.resetPasswordDec,

              style: AppTextStyle.dmSans(

                height: 1.3,
                color: isDark
                    ? JAppColors.darkGray200
                    : JAppColors.lightGray600,
                fontSize: 16.0,
                weight: FontWeight.w400,
              ),),



            SizedBox(height: JSizes.spaceBtwSections,),
            TextFieldWidget(
              hintText: JText.newPassword,
              prefixIcon: Icons.person_outline,
            ),
            SizedBox(height: JSizes.spaceBtwInputFields,),


            TextFieldWidget(
              hintText: JText.repeatPassword,
              prefixIcon: Icons.person_outline,
            ),



            SizedBox(height: JSizes.spaceBtwInputFields +20,),

            MainButton(
              btn_title: JText.resetPassword,
              btn_radius: 10,
              btn_color: JAppColors.main,
              btn_boarder_color: Color(0xff7030F1),
              title_color: Colors.white,
              text_fontweight: FontWeight.w600,
              image_value: false,
            ),

          ],
        ),
      ),
    );
  }

}
