import 'package:flutter/material.dart';
import '../../../../../data/models/messages/message_model.dart';
import '../../../../../utils/common_widgets/EmptyStateWidget.dart';
import '../../../../../utils/common_widgets/ErrorStateWidget.dart';

import 'chat_message_widget.dart';

class MessageListWidget extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final List<MessageModel> messages;
  final ScrollController? scrollController;
  final bool isDark;
  final String otherUserId;
  final String? otherUserProfile;

  const MessageListWidget({
    super.key,
    required this.isLoading,
    required this.errorMessage,
    required this.messages,
    required this.isDark,
    required this.otherUserId,
    this.otherUserProfile,
    this.scrollController,
  });

  String _formatTime(DateTime dateTime) {
    // You can customize format
    return "${dateTime.hour.toString().padLeft(2,'0')}:${dateTime.minute.toString().padLeft(2,'0')}";
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return
        ErrorStateWidget(
        message: errorMessage!,
        onRetry: () {
          // You can pass retry logic through context or a callback
        }, isDark: isDark,
      );
    }

    if (messages.isEmpty) {
      return EmptyStateWidget(
        isDark: isDark,
        title: 'No messages yet.\nSay hello! 👋',
        icon: Icons.chat_bubble_outline,
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];

        // ✅ Check if message is outgoing (current user)
        final bool isOutgoing = msg.sender != otherUserId;

        return ChatMessageWidget(
          message: msg.preview,
          time: _formatTime(msg.createdAt!),
          isOutgoing: isOutgoing,
          avatarUrl: isOutgoing ? null : otherUserProfile,
        );
      },
    );
  }
}