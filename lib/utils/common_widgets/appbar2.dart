import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

class JAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final Widget? leading;
  final List<Widget>? actions;
  final double elevation;
  final Widget? flexibleSpace;
  final Color? backgroundColor;
  final VoidCallback? onBackPressed;
  final bool centerTitle;

  const JAppBar2({
    Key? key,
    required this.title,
    this.showBackButton = true,
    this.leading,
    this.actions,
    this.elevation = 0,
    this.flexibleSpace,
    this.backgroundColor,
    this.onBackPressed,
    this.centerTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return AppBar(
      titleSpacing: showBackButton ? 0 : NavigationToolbar.kMiddleSpacing,
      title: Text(
        title,
        style: AppTextStyle.dmSans(
          color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
          fontSize: JSizes.fontSizeLg,
          weight: FontWeight.w500,
        ),
      ),
      leading: showBackButton
          ? leading ??
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
            ),
            onPressed: onBackPressed ?? () => Navigator.pop(context),
          )
          : null,
      actions: actions,
      elevation: elevation,
      backgroundColor: backgroundColor ??
          (isDark ? JAppColors.darkGray800 : JAppColors.lightGray100),
      flexibleSpace: flexibleSpace,
      centerTitle: centerTitle,
      automaticallyImplyLeading: showBackButton,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}