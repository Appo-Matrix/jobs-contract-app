import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../device/device_utility.dart';

class JAppbar extends StatelessWidget implements PreferredSizeWidget {
  const JAppbar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.showDivider = true,
  });

  final Widget? title;
  final bool showBackArrow;
  final Widget? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: AppBar(
              backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
              elevation: 0,
              centerTitle: false,
              automaticallyImplyLeading: false,
              leading: showBackArrow
                  ? IconButton(
                  onPressed: leadingOnPressed,
                  icon: Icon(Icons.arrow_back, color: JAppColors.primary))
                  : leadingIcon,
              title: title,
              actions: actions,
            ),
          ),
          if (showDivider)
            Divider(
              height: 1,
              thickness: 1,
              color: isDark ? JAppColors.darkGray600 : Colors.grey.shade200,
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(JDeviceUtils.getAppBarHeight() +17);
}