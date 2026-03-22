// // data/models/chat/create_chat_response.dart
// class CreateChatResponse {
//   final String id;
//   final String senderId;
//   final String receiverId;
//   final String message;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   CreateChatResponse({
//     required this.id,
//     required this.senderId,
//     required this.receiverId,
//     required this.message,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory CreateChatResponse.fromJson(Map<String, dynamic> json) {
//     final data = json['data'];
//     return CreateChatResponse(
//       id: data['_id'],
//       senderId: data['senderId'],
//       receiverId: data['receiverId'],
//       message: data['message'],
//       createdAt: DateTime.parse(data['createdAt']),
//       updatedAt: DateTime.parse(data['updatedAt']),
//     );
//   }
// }



class Conversation {
  final String id;
  final List<String> members;
  final DateTime createdAt;
  final DateTime updatedAt;

  Conversation({
    required this.id,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json["_id"],
      members: List<String>.from(json["members"]),
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }
}


class CreateChatResponse {
  final bool success;
  final Conversation conversation;

  CreateChatResponse({
    required this.success,
    required this.conversation,
  });

  factory CreateChatResponse.fromJson(Map<String, dynamic> json) {
    return CreateChatResponse(
      success: json["success"],
      conversation: Conversation.fromJson(json["conversation"]),
    );
  }
}