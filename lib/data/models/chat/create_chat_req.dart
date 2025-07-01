// data/models/chat/create_chat_request.dart
class CreateChatRequest {
  final String senderId;
  final String receiverId;
  final String message;

  CreateChatRequest({
    required this.senderId,
    required this.receiverId,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
    "senderId": senderId,
    "receiverId": receiverId,
    "message": message,
  };
}
