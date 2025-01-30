import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/verify_profile/screens/widgets/profile_verification_container.dart';
import '../../../../../../utils/common_widgets/appbar.dart';
import '../../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/device/device_utility.dart';

class VerifyProfile extends StatefulWidget {
  const VerifyProfile({super.key});

  @override
  State<VerifyProfile> createState() => _VerifyProfileState();
}

class _VerifyProfileState extends State<VerifyProfile> {
  bool isCheckedPhoneNumber = false;
  bool isCheckedPaymentMethod = false;
  bool isCheckedIdentity = false;

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final width = JDeviceUtils.getScreenWidth(context);
    return Scaffold(
      appBar: JAppbar(
        title: Text(
          JText.verifyProfile,
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 26, horizontal: 16),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  JText.next,
                  style: AppTextStyle.dmSans(
                      color: Colors.white,
                      fontSize: 16.0,
                      weight: FontWeight.w600),
                ))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              // Use the reusable ProfileVerificationContainer widget
              ProfileVerificationContainer(
                isChecked: isCheckedPhoneNumber,
                onChanged: (value) {
                  setState(() {
                    isCheckedPhoneNumber = value!;
                  });
                },
                checkboxRadius: 12,
                // Size of the circular checkbox
                title: JText.verifyPhoneNumber,
                description: JText.verifyPhoneNumberDesc,
              ),

              SizedBox(
                height: JSizes.md,
              ),
              ProfileVerificationContainer(
                isChecked: isCheckedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    isCheckedPaymentMethod = value!;
                  });
                },
                checkboxRadius: 12,
                // Size of the circular checkbox
                title: JText.verifyPaymentMethods,
                description: JText.verifyPhoneNumberDesc,
              ),
              SizedBox(
                height: JSizes.md,
              ),

              ProfileVerificationContainer(
                isChecked: isCheckedIdentity,
                onChanged: (value) {
                  setState(() {
                    isCheckedIdentity = value!;
                  });
                },
                checkboxRadius: 12,
                // Size of the circular checkbox
                title: JText.verifyIdentity,
                description: JText.verifyIdentityDesc,
              ),

              SizedBox(
                height: JSizes.spaceBtwSections + 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
