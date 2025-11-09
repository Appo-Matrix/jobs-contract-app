//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
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
//     final backgroundColor = isDark ? JAppColors.darkGray900 : Colors.white;
//
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         statusBarColor: backgroundColor,
//         statusBarIconBrightness:
//             isDark ? Brightness.light : Brightness.dark, // Icon color
//         statusBarBrightness:
//             isDark ? Brightness.dark : Brightness.light, // iOS only
//       ),
//       child: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             color: backgroundColor,
//             boxShadow: showDivider
//                 ? [
//               BoxShadow(
//                 color: isDark
//                     ? Colors.black.withOpacity(0.3)  // 3x stronger for dark mode
//                     : Colors.black.withOpacity(0.1),
//                 blurRadius: isDark ? 8 : 4,  // Larger blur radius in dark mode
//                 offset: const Offset(0, 2),
//               ),
//             ]
//                 : [],
//           ),
//           child: AppBar(
//             backgroundColor: backgroundColor,
//             elevation: 0,
//             titleSpacing: 0,
//             surfaceTintColor: Colors.transparent,
//             scrolledUnderElevation: 0,
//             shadowColor: Colors.transparent,
//             centerTitle: false,
//             automaticallyImplyLeading: false,
//             leading: showBackArrow
//                 ? IconButton(
//               onPressed: leadingOnPressed,
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: JAppColors.primary,
//                 size: 16,
//               ),
//             )
//                 : leadingIcon,
//             title: title,
//             actions: actions,
//           ),
//         ),
//
//         // Column(
//         //   mainAxisSize: MainAxisSize.min,
//         //   children: [
//         //     AppBar(
//         //       backgroundColor: backgroundColor,
//         //       elevation: 0,
//         //
//         //       titleSpacing: 0,
//         //       shadowColor: isDark ? Colors.black45 : Colors.black26,
//         //       // Define shadow color
//         //       surfaceTintColor: Colors.transparent,
//         //       // For Material 3, remove surface tint
//         //       scrolledUnderElevation: 0,
//         //       centerTitle: true,
//         //       automaticallyImplyLeading: false,
//         //
//         //       leading: showBackArrow
//         //           ? IconButton(
//         //               onPressed: leadingOnPressed,
//         //               icon: Icon(
//         //                 Icons.arrow_back,
//         //                 color: JAppColors.primary,
//         //                 size: 16,
//         //               ),
//         //             )
//         //           : leadingIcon,
//         //       title: title,
//         //       actions: actions,
//         //     ),
//         //   ],
//         // ),
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(JDeviceUtils.getAppBarHeight());
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

    // 👇 Automatically decide icon color based on theme


    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor:  isDark ? JAppColors.darkGray900 : Colors.white,
        statusBarIconBrightness:
        isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness:
        isDark ? Brightness.dark : Brightness.light,
      ),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color:  isDark ? JAppColors.darkGray900 : Colors.white,
            boxShadow: showDivider
                ? [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.1),
                blurRadius: isDark ? 8 : 4,
                offset: const Offset(0, 2),
              ),
            ]
                : [],
          ),
          child: AppBar(
            backgroundColor:  isDark ? JAppColors.darkGray900 : Colors.white,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0,
            shadowColor: Colors.transparent,
            centerTitle: false,
            automaticallyImplyLeading: false,
            titleSpacing: 0,

            // ✅ FIXED LEADING LOGIC WITH AUTO COLOR
            leading: showBackArrow
                ? IconButton(
              onPressed: leadingOnPressed,
              icon: Icon(
                Icons.arrow_back,
                size: 16,
                color: isDark ? Colors.white : JAppColors.darkGray800,
              ),
            )
                : (leadingIcon != null
                ? IconButton(
              onPressed: leadingOnPressed,
              icon: IconTheme(
                data: IconThemeData(color: isDark ? Colors.white : JAppColors.darkGray800),
                child: leadingIcon!,
              ),
            )
                : null),

            title: title,
            actions: actions,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(JDeviceUtils.getAppBarHeight());
}
