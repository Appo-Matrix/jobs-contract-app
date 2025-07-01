// data/models/chat/create_chat_response.dart
class CreateChatResponse {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  CreateChatResponse({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreateChatResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return CreateChatResponse(
      id: data['_id'],
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      message: data['message'],
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
    );
  }
}
