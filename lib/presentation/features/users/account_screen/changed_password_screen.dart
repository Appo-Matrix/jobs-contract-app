import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contract_app/presentation/features/users/providers/change_password_provider.dart';
import 'package:provider/provider.dart';

import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../../utils/common_widgets/appbar.dart';
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
  void initState() {
    super.initState();
    // Reset state when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChangePasswordProvider>().resetState();
    });
  }

  void _showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (_) => const Center(
        child: FancyCircularLoader(),
      ),
    );
  }

  Future<void> _handleSave(BuildContext context) async {
    final provider = context.read<ChangePasswordProvider>();

    _showProgressDialog(context);

    final success = await provider.changePassword();

    if (!mounted) return;
    Navigator.pop(context); // Close the loading dialog

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.successMessage.isNotEmpty
              ? provider.successMessage
              : 'Password changed successfully'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      // Navigate back after success
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) Navigator.pop(context);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage.isNotEmpty
              ? provider.errorMessage
              : 'Failed to change password'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Consumer<ChangePasswordProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor:
          isDark ? JAppColors.backGroundDark : Colors.white,
          appBar: JAppbar(
            title: Text(
              'changedPassword',
              style: AppTextStyle.dmSans(
                color: isDark
                    ? JAppColors.darkGray100
                    : JAppColors.lightGray800,
                fontSize: JSizes.fontSizeLg,
                weight: FontWeight.w600,
              ),
            ).tr(),
            leadingIcon: const Icon(Icons.arrow_back),
            leadingOnPressed: () {
              Navigator.pop(context);
            },
          ),
          body: Form(
            key: provider.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: JSizes.spaceBtwItems),
                    Text(
                      'changedPasswordTitle',
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.lightGray100
                            : JAppColors.darkGray500,
                        fontSize: JSizes.fontSizeSm,
                        weight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ).tr(),
                    SizedBox(height: JSizes.spaceBtwInputFields + 4),

                    // ── Current Password ──────────────────────────────────
                    TextFieldWidget(
                      textEditingController: provider.currentPasswordController,
                      subTitle: 'currentPassword',
                      hintText: 'currentPasswordHint',
                      obscureText: !provider.isCurrentPasswordVisible,
                      subtitleColor: isDark
                          ? JAppColors.lightGray300
                          : JAppColors.grayBlue800,
                      titleColor: isDark
                          ? JAppColors.lightGray300
                          : JAppColors.grayBlue800,
                      validator: provider.validateCurrentPassword,
                      suffixIcon: GestureDetector(
                        onTap: provider.toggleCurrentPasswordVisibility,
                        child: Icon(
                          provider.isCurrentPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: isDark
                              ? JAppColors.lightGray300
                              : JAppColors.grayBlue800,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: JSizes.spaceBtwInputFields + 4),

                    // ── New Password ──────────────────────────────────────
                    TextFieldWidget(
                      textEditingController: provider.newPasswordController,
                      subTitle: 'newPasswordTitle',
                      hintText: 'newPassword',
                      obscureText: !provider.isNewPasswordVisible,
                      subtitleColor: isDark
                          ? JAppColors.lightGray300
                          : JAppColors.grayBlue800,
                      titleColor: isDark
                          ? JAppColors.lightGray300
                          : JAppColors.grayBlue800,
                      validator: provider.validateNewPassword,
                      suffixIcon: GestureDetector(
                        onTap: provider.toggleNewPasswordVisibility,
                        child: Icon(
                          provider.isNewPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: isDark
                              ? JAppColors.lightGray300
                              : JAppColors.grayBlue800,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: JSizes.spaceBtwInputFields + 4),

                    // ── Retype Password ───────────────────────────────────
                    TextFieldWidget(
                      textEditingController: provider.retypePasswordController,
                      subTitle: 'retypePassword',
                      hintText: 'retypePasswordTitle',
                      obscureText: !provider.isRetypePasswordVisible,
                      subtitleColor: isDark
                          ? JAppColors.lightGray300
                          : JAppColors.grayBlue800,
                      titleColor: isDark
                          ? JAppColors.lightGray300
                          : JAppColors.grayBlue800,
                      validator: provider.validateRetypePassword,
                      suffixIcon: GestureDetector(
                        onTap: provider.toggleRetypePasswordVisibility,
                        child: Icon(
                          provider.isRetypePasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: isDark
                              ? JAppColors.lightGray300
                              : JAppColors.grayBlue800,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 55),

                    // ── Require all devices row ───────────────────────────
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/tick_icon.png',
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'requireAllDevices',
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
                    const SizedBox(height: 35),

                    // ── Save Button ───────────────────────────────────────
                    MainButton(
                      onTap: provider.isLoading
                          ? null
                          : () => _handleSave(context),
                      btn_title: 'savePassword',
                      btn_radius: 10,
                      btn_color: JAppColors.main,
                      title_color: Colors.white,
                      image_value: false,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}



// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import '../../../../utils/common_widgets/main_button.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../../../utils/constants/sizes.dart';
// import '../../../../../utils/common_widgets/appbar.dart';
// import '../../../../../utils/common_widgets/back_circle.dart';
// import '../../../../../utils/common_widgets/text_field_widget.dart';
// import '../../../../../utils/constants/app_text_style.dart';
// import '../../../../../utils/device/device_utility.dart';
// import '../../../../utils/common_widgets/circular_progess_loader.dart';
//
// class ChangedPasswordScreen extends StatefulWidget {
//   const ChangedPasswordScreen({super.key});
//
//   @override
//   State<ChangedPasswordScreen> createState() => _ChangedPasswordScreenState();
// }
//
// class _ChangedPasswordScreenState extends State<ChangedPasswordScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//     void showProgressDialog(BuildContext context) {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         barrierColor: Colors.black.withOpacity(0.2),
//         builder: (_) => const Center(
//           child: FancyCircularLoader(),
//         ),
//       );
//     }
//
//     bool isLoading = false;
//
//     void handleSave() async {
//       setState(() {
//         isLoading = true;
//       });
//
//       showProgressDialog(context);
//
//       // Simulate saving or perform your save logic
//       await Future.delayed(Duration(seconds: 5));
//
//       Navigator.pop(context); // Close the loading dialog
//
//       setState(() {
//         isLoading = false;
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Profile saved successfully")),
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
//       appBar: JAppbar(
//         title: Text(
//           'changedPassword', // Use the constant
//           style: AppTextStyle.dmSans(
//             color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//             fontSize: JSizes.fontSizeLg,
//             weight: FontWeight.w600,
//           ),
//         ).tr(),
//         leadingIcon: Icon(Icons.arrow_back),
//         leadingOnPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 18, right: 18),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: JSizes.spaceBtwItems,),
//               Text(
//                 'changedPasswordTitle', // Use the constant
//                 style: AppTextStyle.dmSans(
//                     color: isDark
//                         ? JAppColors.lightGray100
//                         : JAppColors.darkGray500,
//                     fontSize: JSizes.fontSizeSm,
//                     weight: FontWeight.w400,
//                     height: 1.5
//                 ),
//               ).tr(),
//               SizedBox(height: JSizes.spaceBtwInputFields + 4),
//               TextFieldWidget(
//                 subTitle: 'currentPassword', // Use the constant
//                 hintText: 'currentPasswordHint',
//                 subtitleColor:
//                 isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
//                 titleColor:
//                 isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
//               ),
//               SizedBox(height: JSizes.spaceBtwInputFields + 4),
//               TextFieldWidget(
//                 subTitle: 'newPasswordTitle', // Use the constant
//                 hintText: 'newPassword',
//                 subtitleColor:
//                 isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
//                 titleColor:
//                 isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
//               ),
//               SizedBox(height: JSizes.spaceBtwInputFields + 4),
//               TextFieldWidget(
//                 subTitle: 'retypePassword', // Use the constant
//                 hintText: 'retypePasswordTitle',
//                 subtitleColor:
//                 isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
//                 titleColor:
//                 isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
//               ),
//               SizedBox(height: 55),
//               Row(
//                 children: [
//                   Image.asset(
//                     'assets/icons/tick_icon.png',
//                     width: 18,
//                     height: 18,
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       'requireAllDevices', // Use the constant
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: AppTextStyle.dmSans(
//                         height: 1.2,
//                         color: isDark
//                             ? JAppColors.lightGray100
//                             : JAppColors.darkGray500,
//                         fontSize: JSizes.fontSizeXESm,
//                         weight: FontWeight.w400,
//                       ),
//                     ).tr(),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 35),
//               MainButton(
//                 onTap: isLoading ? null : handleSave,
//                 btn_title: 'savePassword',
//                 btn_radius: 10,
//                 btn_color: JAppColors.main,
//                 title_color: Colors.white,
//                 image_value: false,
//               ),
//
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

