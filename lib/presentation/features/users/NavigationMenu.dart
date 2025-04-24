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
          backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
          onDestinationSelected: (index) {
            // Check index bounds before assigning
            if (index >= 0 && index < controller.screens.length) {
              controller.selectedIndex.value = index;
            }
          },
          destinations: [
            // Using SVG icons instead of Iconsax
            NavigationDestination(
              icon: SvgPicture.asset(
                JImages.notifications,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                JImages.home,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isDark ? Colors.white60 : JAppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              label: tr('home'),
            ),

            NavigationDestination(
              icon: SvgPicture.asset(
                JImages.con,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                JImages.con,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isDark ? Colors.white60 : JAppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              label: tr('contract'),
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                JImages.messages,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                JImages.messages,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isDark ? Colors.white60 : JAppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              label: tr('message'),
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                JImages.notificationsvg,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                JImages.notificationsvg,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isDark ? Colors.white60 : JAppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              label:tr('notification'),
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
    NotifcationsScreen()
  ];
}
