import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contract_app/presentation/features/users/message/widgets/MessageListWidget.dart';
import 'package:provider/provider.dart';
import 'package:job_contract_app/data/models/chat/ChatModel2.dart';
import 'package:job_contract_app/data/models/messages/message_model.dart';
import 'package:job_contract_app/presentation/features/users/providers/message_provider.dart';

import '../../../../utils/common_widgets/UserAvatar.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/device/device_utility.dart';

class ChatScreen extends StatefulWidget {
  final ChatModel2 chat;

  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MessageProvider>().fetchMessagesByChatId(widget.chat.id);
    });
  }

  @override
  void dispose() {
    context.read<MessageProvider>().leaveChat();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    // ✅ otherUser.id IS the correct receiver — use it directly
    final String receiver = widget.chat.otherUser.id;

    print('✅ receiver: $receiver');
    print('✅ members: ${widget.chat.members}');

    final message = MessageModel(
      id: '',
      conversationId: widget.chat.id,
      sender: '',
      receiver: receiver,
      text: text,
      images: [],
      videos: [],
      files: [],
      audios: [],
      isDelivered: false,
      isRead: false,
    );

    context.read<MessageProvider>().sendMessage(message);
    _textController.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final provider = context.watch<MessageProvider>();
    final otherUser = widget.chat.otherUser;

    if (!provider.isLoading && provider.messages.isNotEmpty) {
      _scrollToBottom();
    }

    return Scaffold(
      appBar: JAppbar(
        title: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 🔹 Avatar with online indicator
                  UserAvatar(
                    user: otherUser,
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        otherUser.fullName,
                        style: AppTextStyle.dmSans(
                          color: isDark
                              ? JAppColors.darkGray100
                              : JAppColors.lightGray900,
                          fontSize: 16.0,
                          weight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            otherUser.isOnline ? 'Online' : 'Offline',
                            style: AppTextStyle.dmSans(
                              color: isDark
                                  ? JAppColors.darkGray100
                                  : JAppColors.lightGray600,
                              fontSize: 12.0,
                              weight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 4),
                          CircleAvatar(
                            radius: 4,
                            backgroundColor:
                            otherUser.isOnline ? Colors.green : Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [

            // ── Date label ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Today',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ),

            // ── Messages ─────────────────────────────────────
            Expanded(
              child: MessageListWidget(
                isLoading: provider.isLoading,
                errorMessage: provider.errorMessage,
                messages: provider.messages,
                isDark: isDark,
                otherUserId: otherUser.id,
                otherUserProfile: otherUser.profile,
                scrollController: _scrollController,
              ),
            ),
            // ── Non-blocking error banner ─────────────────────
            if (provider.errorMessage != null && !provider.isLoading)
              Container(
                width: double.infinity,
                color: Colors.red.shade100,
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  provider.errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),

            // ── Input bar ─────────────────────────────────────
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(
                          minHeight: 48, maxHeight: 120),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark
                            ? JAppColors.darkGray800
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark
                              ? JAppColors.darkGray400
                              : JAppColors.darkGray300,
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
                                isDark
                                    ? JAppColors.lightGray100
                                    : JAppColors.darkGray800,
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
                                color: isDark
                                    ? JAppColors.darkGray100
                                    : JAppColors.lightGray900,
                                fontSize: 16.0,
                                weight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: 'Type your message...',
                                hintStyle: AppTextStyle.dmSans(
                                  height: 1.3,
                                  color: isDark
                                      ? JAppColors.darkGray200
                                      : JAppColors.lightGray600,
                                  fontSize: 16.0,
                                  weight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
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
                                isDark
                                    ? JAppColors.lightGray100
                                    : JAppColors.darkGray800,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark
                            ? JAppColors.darkGray700
                            : JAppColors.darkGray800,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset(
                          JImages.btnsend,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
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