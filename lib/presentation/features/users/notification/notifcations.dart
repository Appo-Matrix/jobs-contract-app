import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/notification/widgets/NotificationDialog.dart';
import 'package:job_contracts/presentation/features/users/notification/widgets/NotificationsContainer.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import 'package:provider/provider.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../routes/app_routes.dart';
import '../home/drawer/custom_navigation_drawer.dart';
import '../home/drawer/widgets/drawer_item.dart';

class NotifcationsScreen extends StatefulWidget {
  const NotifcationsScreen({super.key});

  @override
  State<NotifcationsScreen> createState() => _NotifcationsScreenState();
}

class _NotifcationsScreenState extends State<NotifcationsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      key: scaffoldKey,
      drawer: CustomNavigationDrawer(isDark: isDark),  // Use the new drawer widget
      appBar: JAppbar(
        leadingIcon: GestureDetector(
          onTap: () => {scaffoldKey.currentState?.openDrawer()},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularAvatar(
              isDark: isDark,
              radius: 20,
              imageUrl: JImages.image,
              // Or use asset: true and imagePath: 'assets/images/profile1.jpg' for asset images
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert,
                color:
                isDark ? JAppColors.darkGray100 : JAppColors.darkGray800),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              NotificationsContainer(
                isDark: isDark,
                width: double.infinity,
                height: 130,
              ),
              NotificationDialog(isDark: isDark),
            ],
          ),
        ),
      ),
    );
  }


}
