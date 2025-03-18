import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../device/device_utility.dart';

class JAppbar extends StatelessWidget implements PreferredSizeWidget {
  const JAppbar(
      {super.key,
        this.title,
        this.showBackArrow = false,
        this.leadingIcon,
        this.actions,
        this.leadingOnPressed,});

  final Widget? title;
  final bool showBackArrow;
  final Widget? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
      child: AppBar(
        backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
          
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
            onPressed: leadingOnPressed,
            icon:  Icon(Icons.arrow_back, color: JAppColors.primary))
            : leadingIcon,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(JDeviceUtils.getAppBarHeight());
}