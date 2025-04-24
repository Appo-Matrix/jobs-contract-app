import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/presentation/features/users/message/widgets/message_card.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../home/drawer/custom_navigation_drawer.dart';
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
      drawer: CustomNavigationDrawer(isDark: isDark),  // Use the new drawer widget
      key: _scaffoldKey,

      appBar: JAppbar(
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
}


