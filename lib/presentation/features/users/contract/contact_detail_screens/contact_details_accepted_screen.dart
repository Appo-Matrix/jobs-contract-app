import 'package:flutter/material.dart';

import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';
import '../widgets/contact_details_widget.dart';
import '../widgets/contact_first_widget.dart';

class ContactDetailsAcceptedScreen extends StatelessWidget {
  const ContactDetailsAcceptedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.contractDetail,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: Padding(
          padding: const EdgeInsets.all(3.0),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              ContactFirstWidget(title: 'Status', subTitle: 'Accepted', isDark: isDark,),
              SizedBox(height: 10),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Start date', subTitle: 'Jan 20,2025',),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Hourly rate', subTitle: '\$10.00/hr',),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Rate increase', subTitle: 'None',),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Weekly limit', subTitle: 'Back-End Development',),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'offer expires', subTitle: 'Jan 22,2025',),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Offer date', subTitle: 'Jan 21,2025',),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Manual time allowed', subTitle: 'No',),
              Divider(),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: MainButton(
                      btn_title: 'Message',
                      btn_radius: 8,
                      btn_color: Colors.transparent,
                      btn_boarder_color: JAppColors.primary,
                      title_color: JAppColors.primary,
                      image_value: false,
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 150,
                    child: MainButton(
                      btn_title: 'End Contract',
                      btn_radius: 8,
                      btn_color: JAppColors.primary,
                      btn_boarder_color: Colors.transparent,
                      title_color: Colors.white,
                      image_value: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}




