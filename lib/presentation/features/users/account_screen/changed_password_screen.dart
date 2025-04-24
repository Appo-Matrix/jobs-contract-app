import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/common_widgets/main_button.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../utils/common_widgets/circular_progess_loader.dart';

class ChangedPasswordScreen extends StatefulWidget {
  const ChangedPasswordScreen({super.key});

  @override
  State<ChangedPasswordScreen> createState() => _ChangedPasswordScreenState();
}

class _ChangedPasswordScreenState extends State<ChangedPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    void showProgressDialog(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.2),
        builder: (_) => const Center(
          child: FancyCircularLoader(),
        ),
      );
    }

    bool isLoading = false;

    void handleSave() async {
      setState(() {
        isLoading = true;
      });

      showProgressDialog(context);

      // Simulate saving or perform your save logic
      await Future.delayed(Duration(seconds: 5));

      Navigator.pop(context); // Close the loading dialog

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile saved successfully")),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          'changedPassword', // Use the constant
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: JSizes.fontSizeLg,
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
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: JSizes.spaceBtwItems,),
              Text(
                'changedPasswordTitle', // Use the constant
                style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.lightGray100
                        : JAppColors.darkGray500,
                    fontSize: JSizes.fontSizeSm,
                    weight: FontWeight.w400,
                    height: 1.5
                ),
              ).tr(),
              SizedBox(height: JSizes.spaceBtwInputFields + 4),
              TextFieldWidget(
                subTitle: 'currentPassword', // Use the constant
                hintText: 'currentPasswordHint',
                subtitleColor:
                isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields + 4),
              TextFieldWidget(
                subTitle: 'newPasswordTitle', // Use the constant
                hintText: 'newPassword',
                subtitleColor:
                isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields + 4),
              TextFieldWidget(
                subTitle: 'retypePassword', // Use the constant
                hintText: 'retypePasswordTitle',
                subtitleColor:
                isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                titleColor:
                isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
              ),
              SizedBox(height: 55),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/tick_icon.png',
                    width: 18,
                    height: 18,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'requireAllDevices', // Use the constant
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.dmSans(
                        height: 1.2,
                        color: isDark
                            ? JAppColors.lightGray100
                            : JAppColors.darkGray500,
                        fontSize: JSizes.fontSizeXESm,
                        weight: FontWeight.w400,
                      ),
                    ).tr(),
                  ),
                ],
              ),
              SizedBox(height: 35),
              MainButton(
                onTap: isLoading ? null : handleSave,
                btn_title: 'savePassword',
                btn_radius: 10,
                btn_color: JAppColors.main,
                btn_boarder_color: Colors.transparent,
                title_color: Colors.white,
                image_value: false,
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
