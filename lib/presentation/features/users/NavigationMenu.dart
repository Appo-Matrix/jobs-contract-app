// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:job_contracts/presentation/features/users/contract/contract_screen.dart';
// import 'package:job_contracts/presentation/features/users/home/home_screen.dart';
// import 'package:job_contracts/presentation/features/users/notification/notifcations.dart';
// import 'package:job_contracts/utils/constants/image_string.dart';
// import 'package:job_contracts/utils/device/device_utility.dart';
//
// import '../../../utils/constants/colors.dart';
// import 'blog/blog_screen.dart';
// import 'finanance_report/finance_reports_screen.dart';
// import 'message/message_screen.dart';
//
// class NavigationMenu extends StatelessWidget {
//   const NavigationMenu({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(NavigationController());
//     final bool isDark = JDeviceUtils.isDarkMode(context);
//     return Scaffold(
//       bottomNavigationBar: Obx(
//         () => NavigationBar(
//           height: 60,
//           elevation: 0,
//           selectedIndex: controller.selectedIndex.value,
//           backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
//           onDestinationSelected: (index) {
//             // Check index bounds before assigning
//             if (index >= 0 && index < controller.screens.length) {
//               controller.selectedIndex.value = index;
//             }
//           },
//           destinations: [
//             // Using SVG icons instead of Iconsax
//             NavigationDestination(
//               icon: SvgPicture.asset(
//                 JImages.notifications,
//                 width: 20,
//                 height: 20,
//                 colorFilter: ColorFilter.mode(
//                   isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
//                   BlendMode.srcIn,
//                 ),
//               ),
//               selectedIcon: SvgPicture.asset(
//                 JImages.home,
//                 width: 20,
//                 height: 20,
//                 colorFilter: ColorFilter.mode(
//                   isDark ? Colors.white60 : JAppColors.primary,
//                   BlendMode.srcIn,
//                 ),
//               ),
//               label: tr('home'),
//             ),
//
//             NavigationDestination(
//               icon: SvgPicture.asset(
//                 JImages.con,
//                 width: 20,
//                 height: 20,
//                 colorFilter: ColorFilter.mode(
//                   isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
//                   BlendMode.srcIn,
//                 ),
//               ),
//               selectedIcon: SvgPicture.asset(
//                 JImages.con,
//                 width: 20,
//                 height: 20,
//                 colorFilter: ColorFilter.mode(
//                   isDark ? Colors.white60 : JAppColors.primary,
//                   BlendMode.srcIn,
//                 ),
//               ),
//               label: tr('contract'),
//             ),
//             NavigationDestination(
//               icon: SvgPicture.asset(
//                 JImages.messages,
//                 width: 20,
//                 height: 20,
//                 colorFilter: ColorFilter.mode(
//                   isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
//                   BlendMode.srcIn,
//                 ),
//               ),
//               selectedIcon: SvgPicture.asset(
//                 JImages.messages,
//                 width: 20,
//                 height: 20,
//                 colorFilter: ColorFilter.mode(
//                   isDark ? Colors.white60 : JAppColors.primary,
//                   BlendMode.srcIn,
//                 ),
//               ),
//               label: tr('message'),
//
//             ),
//             NavigationDestination(
//               icon:
//               SvgPicture.asset(
//                 JImages.blogs,
//                 width: 20,
//                 height: 20,
//                 colorFilter: ColorFilter.mode(
//                   isDark ? JAppColors.lightGray100 :JAppColors.darkGray800,
//                   BlendMode.srcIn,
//
//                 ),
//               ),
//               selectedIcon: SvgPicture.asset(
//                 JImages.blogs,
//                 width: 20,
//                 height: 20,
//                 colorFilter: ColorFilter.mode(
//                   isDark ? Colors.white60 : JAppColors.primary,
//                   BlendMode.srcIn,
//                 ),
//
//               ),
//               label: tr('blogs'),
//             ),
//
//             NavigationDestination(
//               icon: SvgPicture.asset(
//                 JImages.reports,
//                 width: 20,
//                 height: 20,
//                 colorFilter: ColorFilter.mode(
//                   isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
//                   BlendMode.srcIn,
//                 ),
//               ),
//               selectedIcon: SvgPicture.asset(
//                 JImages.notificationsvg,
//                 width: 20,
//                 height: 20,
//                 colorFilter: ColorFilter.mode(
//                   isDark ? Colors.white60 : JAppColors.primary,
//                   BlendMode.srcIn,
//                 ),
//               ),
//               label:tr('reports'),
//             ),
//           ],
//         ),
//       ),
//       body: Obx(() => controller.screens[controller.selectedIndex.value]),
//     );
//   }
// }
//
// class NavigationController extends GetxController {
//   final Rx<int> selectedIndex = 0.obs;
//
//   final List<Widget> screens = [
//     HomeScreen(),
//     ContractsScreen(),
//     MessageScreen(),
//     BlogScreen(),
//
//     FinanceReportScreen()
//   ];
// }


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_contracts/presentation/features/users/contract/contract_screen.dart';
import 'package:job_contracts/presentation/features/users/home/home_screen.dart';
import 'package:job_contracts/presentation/features/users/notification/notifcations.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../utils/constants/colors.dart';
import 'blog/blog_screen.dart';
import 'finanance_report/finance_reports_screen.dart';
import 'message/message_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final bool isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 60,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: isDark ? JAppColors.darkGray800 : JAppColors.white,
          indicatorColor: isDark
              ? JAppColors.primary.withOpacity(0.15)
              : JAppColors.primary.withOpacity(0.1),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (index) {
            if (index >= 0 && index < controller.screens.length) {
              controller.selectedIndex.value = index;
            }
          },
          destinations: [
            // Home
            NavigationDestination(
              icon: SvgPicture.asset(
                JImages.home,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  isDark ? JAppColors.darkGray400 : JAppColors.lightGray600,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                JImages.home,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  JAppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              label: tr('home'),
            ),

            // Contract
            NavigationDestination(
              icon: SvgPicture.asset(
                JImages.con,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  isDark ? JAppColors.darkGray400 : JAppColors.lightGray600,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                JImages.con,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  JAppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              label: tr('contract'),
            ),

            // Messages
            NavigationDestination(
              icon: SvgPicture.asset(
                JImages.messages,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  isDark ? JAppColors.darkGray400 : JAppColors.lightGray600,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                JImages.messages,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  JAppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              label: tr('message'),
            ),

            // Blogs
            NavigationDestination(
              icon: SvgPicture.asset(
                JImages.blogs,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  isDark ? JAppColors.darkGray400 : JAppColors.lightGray600,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                JImages.blogs,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  JAppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              label: tr('blogs'),
            ),

            // Reports
            NavigationDestination(
              icon: SvgPicture.asset(
                JImages.reports,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  isDark ? JAppColors.darkGray400 : JAppColors.lightGray600,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                JImages.reports,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  JAppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              label: tr('reports'),
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = [
    HomeScreen(),
    ContractsScreen(),
    MessageScreen(),
    BlogScreen(),
    FinanceReportScreen(),
  ];
}