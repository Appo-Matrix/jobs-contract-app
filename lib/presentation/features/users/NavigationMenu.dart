
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_contracts/presentation/features/users/home/home_screen.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key, });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 60,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: Colors.white,
          onDestinationSelected: (index) {
            // Check index bounds before assigning
            if (index >= 0 && index < controller.screens.length) {
              controller.selectedIndex.value = index;
            }
          },
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home, size: 20), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.export, size: 20), label: 'Explore'),
            NavigationDestination(icon: Icon(Iconsax.camera, size: 20), label: 'Post'),
            NavigationDestination(icon: Icon(Icons.person, size: 20), label: 'Profile'),
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
    Container(),
    Container(),
    Container(),
  ];
}
