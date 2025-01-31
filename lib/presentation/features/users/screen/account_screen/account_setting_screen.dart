import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/screen/account_screen/widgets/account_widget.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/constants/app_text_style.dart';



class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text(
          JText.accountSetting,
          style: AppTextStyle.dmSans(
            color: Colors.black,
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.w600,
          ),
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 20),
          child: Column(
            children: [
              Text(
                JText.accountSettingText,
                style: AppTextStyle.dmSans(
                  color: JAppColors.lightGray500,
                  fontSize: JSizes.fontSizeMd,
                  weight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 10),
              AccountWidgetContainer(
                iconsImage: JImages.userIcon,
                title: JText.profileInfo,
                lastIcon: Icons.arrow_forward_ios_outlined,
                subTitle: JText.changeInfo,
              ),
              SizedBox(height: 15),
              AccountWidgetContainer(
                iconsImage: JImages.lock,
                title: JText.changePassword,
                lastIcon: Icons.arrow_forward_ios_outlined,
                subTitle: JText.changeYourPassword,
              ),
              SizedBox(height: 15),
              AccountWidgetContainer(
                iconsImage: JImages.payment,
                title: JText.paymentMethodTitle,
                lastIcon: Icons.arrow_forward_ios_outlined,
                subTitle: JText.addCreditTitle,
              ),
              SizedBox(height: 15),
              AccountWidgetContainer(
                iconsImage: JImages.location,
                title: JText.locationTitle,
                lastIcon: Icons.arrow_forward_ios_outlined,
                subTitle: JText.locationSubTitle,
              ),
              SizedBox(height: 15),
              AccountWidgetContainer(
                iconsImage: JImages.facebook,
                title: JText.profileInfo,
                lastIcon: Icons.arrow_forward_ios_outlined,
                subTitle: JText.changeInfo,
              ),


        
        
            ],
          ),
        ),
      ),
    );
  }
}
