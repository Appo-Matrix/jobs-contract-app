import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

class JAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final double elevation;
  final Widget? flexibleSpace;
  final Color? backgroundColor;
  final VoidCallback? onBackPressed;
  final bool centerTitle;

  const JAppBar2({
    Key? key,
    required this.title,
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
      // Use custom title layout
      title: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: onBackPressed ?? () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(

              children: [


                GestureDetector(
                  onTap: onBackPressed,
                  child: Icon(Icons.arrow_back ,
                  color: isDark ? JAppColors.darkGray200 : JAppColors.darkGray600,
                  size: 18,

                  ),
                ),
                SizedBox(width: 4,),
                Text(
                  title,
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.darkGray300 : JAppColors.darkGray600,
                    fontSize: 14.0,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      titleSpacing: 0,
      // Remove default leading widget
      leading: Container(),
      leadingWidth: 0,
      actions: actions,
      elevation: elevation,
      backgroundColor: backgroundColor ??
          (isDark ? JAppColors.backGroundDark : Colors.white),
      flexibleSpace: flexibleSpace,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}