import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/sizes.dart';

import '../../../../../../utils/common_widgets/appbar.dart';
import '../../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/device/device_utility.dart';

class VerifyPhoneNumber extends StatefulWidget {
  const VerifyPhoneNumber({super.key});

  @override
  State<VerifyPhoneNumber> createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final width = JDeviceUtils.getScreenWidth(context);
    final TextEditingController textEditingController = TextEditingController();
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
          radius: 20,  // Modify the radius to make it larger
          child: Icon(
            CupertinoIcons.back,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              // Use the reusable ProfileVerificationContainer widget

              SizedBox(height: JSizes.spaceBtwSections +20,),

              TextFieldWidget(hintText: JText.enterPhoneNumber ,),
              SizedBox(height: JSizes.spaceBtwInputFields+20,),
              SizedBox(
                  width: double.infinity,


                  child: ElevatedButton(onPressed: (){}, child: Text(JText.next ,style: AppTextStyle.dmSans(color: Colors.white, fontSize: 16.0, weight: FontWeight.w600),)))
            ],
          ),
        ),
      ),
    );
  }
}
