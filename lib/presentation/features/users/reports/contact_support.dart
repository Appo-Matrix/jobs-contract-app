import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import 'widgets/support_option_widget.dart'; // Import the new widget

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.customerSupport,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

             SizedBox(height: JSizes.spaceBtwSections),

            SupportOptionWidget(
              iconAsset: JImages.chatsupp, // Replace with your actual asset path
              title: JText.chatWithSupport,
              description: JText.chatWithSupportDec,
              onTap: () {
                
                AppRouter.router.push('/reportScreen');
                // Navigate to chat screen
              },
              isDark: isDark,
            ),

            // SizedBox(height: JSizes.spaceBtwSections),
             SizedBox(height: JSizes.spaceBtwSections),


            SupportOptionWidget(
              iconAsset: JImages.viewreq, // Replace with your actual asset path
              title: JText.viewMyRequest,
              description: JText.viewMyRequestDes,
              onTap: () {

                AppRouter.router.push('/supportRequestsScreen');

              },
              isDark: isDark,
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}