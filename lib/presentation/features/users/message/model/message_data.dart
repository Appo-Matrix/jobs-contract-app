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
