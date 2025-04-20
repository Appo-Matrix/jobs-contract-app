import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/presentation/features/users/message/widgets/chat_message_widget.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  // Profile Picture
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(width: 4),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(JImages.image),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bessie Cooper",
                        style: AppTextStyle.dmSans(
                          color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                          fontSize: 16.0,
                          weight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "Online",
                            style: AppTextStyle.dmSans(
                              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                              fontSize: 13.0,
                              weight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Today',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            // Chat messages
// In your ChatScreen's ListView:
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Outgoing message
                  ChatMessageWidget(
                    message: 'You did your job well!',
                    time: '09:28 AM',
                    isOutgoing: true,
                  ),

                  // Incoming message
                  ChatMessageWidget(
                    message: 'Hello! Nazrul How are you?',
                    time: '09:29 AM',
                    isOutgoing: false,
                    avatarUrl: 'https://randomuser.me/api/portraits/women/67.jpg',
                  ),

                  // Add more messages as needed
                  ChatMessageWidget(
                    message: 'You did your job well!',
                    time: '09:30 AM',
                    isOutgoing: true,
                  ),

                  ChatMessageWidget(
                    message: 'Have a great working week!',
                    time: '09:35 AM',
                    isOutgoing: false,
                    avatarUrl: 'https://randomuser.me/api/portraits/women/67.jpg',
                  ),

                  // ...rest of your messages
                ],
              ),
            ),
            // Message input - UPDATED for multi-line expansion
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 48,
                        maxHeight: 120,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark ? JAppColors.darkGray800 : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark ? JAppColors.darkGray400 : JAppColors.darkGray300,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: SvgPicture.asset(
                              JImages.doct,
                              width: 18,
                              height: 18,
                              colorFilter: ColorFilter.mode(
                                isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: TextField(
                              controller: _textController,
                              maxLines: 5,
                              minLines: 1,
                              keyboardType: TextInputType.multiline,
                              style: AppTextStyle.dmSans(
                                height: 1.3,
                                color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                                fontSize: 16.0,
                                weight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: 'Type your message...',
                                hintStyle: AppTextStyle.dmSans(
                                  height: 1.3,
                                  color: isDark ? JAppColors.darkGray200 : JAppColors.lightGray600,
                                  fontSize: 16.0,
                                  weight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 8,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: SvgPicture.asset(
                              JImages.gallery,
                              width: 18,
                              height: 18,
                              colorFilter: ColorFilter.mode(
                                isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark ? JAppColors.darkGray700 : JAppColors.darkGray800,
                      ),
                      child: GestureDetector(
                        onTap: (){},
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SvgPicture.asset(
                            JImages.btnsend,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }


}