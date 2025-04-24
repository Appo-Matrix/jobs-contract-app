// import 'package:flutter/material.dart';
// import '../constants/colors.dart';
// import '../device/device_utility.dart';
//
// class JAppbar extends StatelessWidget implements PreferredSizeWidget {
//   const JAppbar({
//     super.key,
//     this.title,
//     this.showBackArrow = false,
//     this.leadingIcon,
//     this.actions,
//     this.leadingOnPressed,
//     this.showDivider = true,
//   });
//
//   final Widget? title;
//   final bool showBackArrow;
//   final Widget? leadingIcon;
//   final List<Widget>? actions;
//   final VoidCallback? leadingOnPressed;
//   final bool showDivider;
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//
//     return SafeArea(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           AppBar(
//             backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
//             elevation: 0,
//             centerTitle: false,
//             automaticallyImplyLeading: false,
//             leading: showBackArrow
//                 ? IconButton(
//                 onPressed: leadingOnPressed,
//                 icon: Icon(Icons.arrow_back, color: JAppColors.primary))
//                 : leadingIcon,
//             title: title,
//             actions: actions,
//
//           ),
//           // if (showDivider)
//           //   Divider(
//           //     height: 1,
//           //     thickness: 1,
//           //     color: isDark ? JAppColors.darkGray600 : Colors.grey.shade200,
//           //   ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(JDeviceUtils.getAppBarHeight() +17);
// }

// import 'package:flutter/material.dart';
// import '../constants/colors.dart';
// import '../device/device_utility.dart';
//
// class JAppbar extends StatelessWidget implements PreferredSizeWidget {
//   const JAppbar({
//     super.key,
//     this.title,
//     this.showBackArrow = false,
//     this.leadingIcon,
//     this.actions,
//     this.leadingOnPressed,
//     this.showDivider = true,
//   });
//
//   final Widget? title;
//   final bool showBackArrow;
//   final Widget? leadingIcon;
//   final List<Widget>? actions;
//   final VoidCallback? leadingOnPressed;
//   final bool showDivider;
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//
//     return SafeArea(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           AppBar(
//             backgroundColor: isDark ? JAppColors.appbarDark : Colors.white,
//             elevation: 0,
//             centerTitle: false,
//             automaticallyImplyLeading: false,
//             leading: showBackArrow
//                 ? IconButton(
//                 onPressed: leadingOnPressed,
//                 icon: Icon(Icons.arrow_back, color: JAppColors.primary))
//                 : leadingIcon,
//             title: title,
//             actions: actions,
//           ),
//           // if (showDivider)
//           //   Divider(
//           //     height: 1,
//           //     thickness: 1,
//           //     color: isDark ? JAppColors.darkGray600 : Colors.grey.shade200,
//           //   ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(JDeviceUtils.getAppBarHeight() +17);
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final backgroundColor = isDark ? JAppColors.backGroundDark : Colors.white;



    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
        statusBarIconBrightness:
        isDark ? Brightness.light : Brightness.dark, // Icon color
        statusBarBrightness:
        isDark ? Brightness.dark : Brightness.light, // iOS only
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              backgroundColor: backgroundColor,
              elevation: 0,
              shadowColor: isDark ? Colors.black45 : Colors.black26, // Define shadow color
              surfaceTintColor: Colors.transparent, // For Material 3, remove surface tint
              scrolledUnderElevation: 0,
              centerTitle: false,
              automaticallyImplyLeading: false,

              leading: showBackArrow
                  ? IconButton(
                onPressed: leadingOnPressed,
                icon:
                Icon(Icons.arrow_back, color: JAppColors.primary ,size: 16,),
              )
                  : leadingIcon,
              title: title,
              actions: actions,
            ),
            // Uncomment if you want divider
            // if (showDivider)
            //   Divider(
            //     height: 1,
            //     thickness: 1,
            //     color:
            //         isDark ? JAppColors.darkGray600 : Colors.grey.shade200,
            //   ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(JDeviceUtils.getAppBarHeight());
}
