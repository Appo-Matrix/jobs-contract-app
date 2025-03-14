
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_contracts/presentation/features/users/home/home_screen.dart';
import 'package:job_contracts/presentation/features/users/notification/notifcations.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../utils/constants/colors.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key, });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final bool isDark= JDeviceUtils.isDarkMode(context);
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
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home, size: 20), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.export, size: 20), label: 'Search'),
            NavigationDestination(icon: Icon(Iconsax.camera, size: 20), label: 'Contract'),
            NavigationDestination(icon: Icon(Icons.chat_rounded, size: 20), label: 'Messages'),
            NavigationDestination(icon: Icon(Icons.notifications, size: 20), label: 'Notification'),
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
    const HomeScreen(),
    Container(
      color: Colors.red,
    ),
    Container(color: Colors.blue,),
    Container(color: Colors.blue,),
    NotifcationsScreen(),
  ];
}
