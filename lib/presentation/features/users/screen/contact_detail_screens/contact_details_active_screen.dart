import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/screen/contact_detail_screens/widgets/contact_details_widget.dart';
import 'package:job_contracts/presentation/features/users/screen/contact_detail_screens/widgets/contact_first_widget.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';

class ContactDetailsActiveScreen extends StatelessWidget {
  const ContactDetailsActiveScreen({super.key});

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
              ContactFirstWidget(title: 'Status', subTitle: 'Active', isDark: isDark,),
              SizedBox(height: 10),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Order ID', subTitle: 'DT-43-JSD8934',),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Order date', subTitle: 'Jan 20,2025',),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Delivery date', subTitle: 'Feb 20,2025',),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Total price', subTitle: '\$4500',),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Service fees', subTitle: '\$5',),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Description', subTitle: 'Back-End Development',),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Deliverables', subTitle: 'Design files',),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Number of revisions', subTitle: 'Unlimited',),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Delivery time', subTitle: '32 Days',),
              Divider(),
              ContactDetailsWidget(isDark: isDark, title: 'Cancel order', subTitle: 'No',),
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




