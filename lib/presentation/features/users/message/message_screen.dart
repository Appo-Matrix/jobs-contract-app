import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/presentation/features/users/message/widgets/message_card.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../home/drawer/widgets/drawer_item.dart';
import 'model/message_data.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // Sample message data
  final List<MessageData> messages = [
    MessageData(
      name: "Bessie Cooper",
      message: "Sed ut perspiciatis unde",
      time: "3:50 pm",
      avatar: JImages.image,
      unreadCount: 2,
      isOnline: true,
    ),
    MessageData(
      name: "Farhan Ullah",
      message: "Sed ut perspiciatis unde",
      time: "3:50 pm",
      avatar: JImages.image,
      unreadCount: 4,
      isOnline: true,
    ),
    MessageData(
      name: "Alita ali",
      message: "Sed ut perspiciatis unde",
      time: "3:50 pm",
      avatar: JImages.image,
      unreadCount: 1,
      isOnline: true,
    ),
    MessageData(
      name: "Sheeza Hamza",
      message: "Sed ut perspiciatis unde",
      time: "3:50 pm",
      avatar: JImages.image,
      unreadCount: 5,
      isOnline: true,
    ),
    MessageData(
      name: "Zakir Hussain",
      message: "Sed ut perspiciatis unde",
      time: "3:50 pm",
      avatar: JImages.image,
      unreadCount: 1,
      isOnline: true,
    ),
    MessageData(
      name: "Bessie Cooper",
      message: "Sed ut perspiciatis unde",
      time: "3:50 pm",
      avatar: JImages.image,
      unreadCount: 2,
      isOnline: true,
    ),
    MessageData(
      name: "Basit Ali",
      message: "Sed ut perspiciatis unde",
      time: "3:50 pm",
      avatar: JImages.image,
      unreadCount: 3,
      isOnline: true,
    ),
    MessageData(
      name: "Evelyn Harrison",
      message: "Sed ut perspiciatis unde",
      time: "3:50 pm",
      avatar: JImages.image,
      unreadCount: 6,
      isOnline: true,
    ),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      drawer: _buildNavigationDrawer(context, isDark),
      key: _scaffoldKey,

      appBar: JAppbar(
        title: Text(JText.message ,style: AppTextStyle.dmSans(color: isDark ? JAppColors.lightGray100 : JAppColors.lightGray800, fontSize: 16.0, weight: FontWeight.w500),),
        leadingIcon: GestureDetector(
          onTap: ()=>{
            print('click'),
            _scaffoldKey.currentState?.openDrawer()

          },

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
            icon:  Icon(Icons.more_vert, color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? JAppColors.darkGray700 : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SvgPicture.asset(
                    JImages.search,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      isDark ? JAppColors.lightGray100 :JAppColors.darkGray800,
                      BlendMode.srcIn,

                    ),
                  ),

                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search message',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: TextStyle(color: isDark ? JAppColors.lightGray100 : Colors.grey),
                      ),
                      style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageCard(
                  data: messages[index],
                  isDark: isDark,
                  onTap: () {

                    AppRouter.router.push('/chatScreen');
                    // Navigate to chat detail screen
                    print("Tapped on ${messages[index].name}'s chat");
                  },
                );
              },
            ),
          ),

          // Message list
        ],
      ),
    );
  }
  Widget _buildNavigationDrawer(BuildContext context, bool isDark) {
    return Drawer(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,

      child: Column(
        children: [
          // Custom drawer header with profile in a row
          Container(

            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // Close the drawer first

                        Navigator.pop(context);
                        // Navigate to profile screen
                        AppRouter.router.push('/profileScreen');
                      },
                      child: CircularAvatar(
                        isDark: isDark,
                        radius: 30,
                        imageUrl: JImages.image,
                      ),
                    ),                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: AppTextStyle.dmSans(
                            fontSize: JSizes.fontSizeMd,
                            weight: FontWeight.w600,
                            color:isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '@johndoe',
                          style: AppTextStyle.dmSans(
                            fontSize: 14.0,
                            weight: FontWeight.w400,
                            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),


          Divider(),
          // Drawer items using the custom widget
          DrawerItem(
            iconPath: JImages.profilesetting,
            title: 'Account Settings',
            iconColor:isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);

              AppRouter.router.push('/accountSettingScreen');
              // Navigate to home
            },
          ),

          DrawerItem(
            iconPath: JImages.report,
            title: 'Financial Report',
            iconColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              AppRouter.router.push('/contactSupportScreen');

              // Navigate to profile
            },
          ),

          DrawerItem(
            iconPath: JImages.proposal,
            title: 'Proposal',
            iconColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              // AppRouter.router.push('/membershipPlansScreen');
              // Navigate to applications
            },
          ),
          DrawerItem(
            iconPath: JImages.proposal,
            title: 'My Ads',
            iconColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              AppRouter.router.push('/myAdsScreen');
              // Navigate to applications
            },
          ),
          DrawerItem(
            iconPath: JImages.upgrade,
            title: 'Upgrade',
            iconColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              AppRouter.router.push('/membershipPlansScreen');
              // Navigate to applications
            },
          ),
          DrawerItem(
            iconPath: JImages.language,
            title: 'Language',
            iconColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              AppRouter.router.push('/languageScreen');
              // Navigate to applications
            },
          ),

          DrawerItem(
            iconPath: JImages.helpsupport,
            title: 'Help & Support',
            iconColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              AppRouter.router.push('/contactSupportScreen');

              // Navigate to notifications
            },
          ),


          DrawerItem(
            iconPath: JImages.logout_icon,
            title: 'Logout',
            iconColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings
            },
          ),

        ],
      ),
    );
  }
}


