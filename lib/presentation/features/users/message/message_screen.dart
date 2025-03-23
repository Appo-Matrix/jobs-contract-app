import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';

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
      avatar: "assets/images/avatars/bessie.jpg",
      unreadCount: 2,
      isOnline: true,
    ),
    MessageData(
      name: "Farhan Ullah",
      message: "Sed ut perspiciatis unde",
      time: "3:50 pm",
      avatar: "assets/images/avatars/farhan.jpg",
      unreadCount: 4,
      isOnline: true,
    ),
    MessageData(
      name: "Alita ali",
      message: "Sed ut perspiciatis unde",
      time: "3:50 pm",
      avatar: "assets/images/avatars/alita.jpg",
      unreadCount: 1,
      isOnline: true,
    ),
    MessageData(
      name: "Sheeza Hamza",
      message: "Sed ut perspiciatis unde",
      time: "3:50 pm",
      avatar: "assets/images/avatars/sheeza.jpg",
      unreadCount: 5,
      isOnline: true,
    ),
    MessageData(
      name: "Zakir Hussain",
      message: "Sed ut perspiciatis unde",
      time: "3:50 pm",
      avatar: "assets/images/avatars/zakir.jpg",
      unreadCount: 1,
      isOnline: true,
    ),
    MessageData(
      name: "Bessie Cooper",
      message: "Sed ut perspiciatis unde",
      time: "3:50 pm",
      avatar: "assets/images/avatars/bessie.jpg",
      unreadCount: 2,
      isOnline: true,
    ),
    MessageData(
      name: "Basit Ali",
      message: "Sed ut perspiciatis unde",
      time: "3:50 pm",
      avatar: "assets/images/avatars/basit.jpg",
      unreadCount: 3,
      isOnline: true,
    ),
    MessageData(
      name: "Evelyn Harrison",
      message: "Sed ut perspiciatis unde",
      time: "3:50 pm",
      avatar: "assets/images/avatars/evelyn.jpg",
      unreadCount: 6,
      isOnline: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      appBar: JAppbar(
        leadingIcon: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BackCircle(
              isDark: isDark,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: Text(
          "Messages",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : JAppColors.lightGray900,
          ),
        ),
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

class MessageData {
  final String name;
  final String message;
  final String time;
  final String avatar;
  final int unreadCount;
  final bool isOnline;

  MessageData({
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    required this.unreadCount,
    required this.isOnline,
  });
}

class MessageCard extends StatelessWidget {
  final MessageData data;
  final bool isDark;
  final VoidCallback onTap;

  const MessageCard({
    Key? key,
    required this.data,
    required this.isDark,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(data.avatar),
                ),
                if (data.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? JAppColors.darkGray800 : Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),

            // Message content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: AppTextStyle.dmSans(
                      fontSize: 16.0,
                      weight: FontWeight.w500,
                      color: isDark ? Colors.white : JAppColors.lightGray900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.message,
                    style: AppTextStyle.dmSans(
                      fontSize: 12.0,
                      weight: FontWeight.w400,
                      color: isDark ? JAppColors.lightGray100 : JAppColors.lightGray600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Time and unread count
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.time,
                  style: AppTextStyle.dmSans(
                    fontSize: 12.0,
                    weight: FontWeight.w300,
                    color: isDark ? JAppColors.lightGray100 : JAppColors.lightGray600,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: JAppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    data.unreadCount.toString(),
                    style: AppTextStyle.dmSans(
                      fontSize: 10.0,
                      weight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}