import 'package:flutter/material.dart';

class ChatMessageWidget extends StatelessWidget {
  final String message;
  final String time;
  final bool isOutgoing;
  final String? avatarUrl;

  const ChatMessageWidget({
    super.key,
    required this.message,
    required this.time,
    required this.isOutgoing,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isOutgoing ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isOutgoing && avatarUrl != null) _buildAvatar(),
          if (!isOutgoing) const SizedBox(width: 8),
          Column(
            crossAxisAlignment: isOutgoing ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 250),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isOutgoing ? Colors.purple : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    color: isOutgoing ? Colors.white : Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.red.shade700,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          avatarUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.person, size: 20, color: Colors.grey.shade400);
          },
        ),
      ),
    );
  }
}