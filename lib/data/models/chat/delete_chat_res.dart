// data/models/chat/delete_chat_response.dart
class DeleteChatResponse {
  final bool success;
  final String message;
  final String chatId;
  final String jobId;
  final String senderId;
  final String receiverId;

  DeleteChatResponse({
    required this.success,
    required this.message,
    required this.chatId,
    required this.jobId,
    required this.senderId,
    required this.receiverId,
  });

  factory DeleteChatResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return DeleteChatResponse(
      success: json['success'],
      message: json['message'],
      chatId: data['_id'],
      jobId: data['jobId'],
      senderId: data['senderId'],
      receiverId: data['receiverId'],
    );
  }
}
