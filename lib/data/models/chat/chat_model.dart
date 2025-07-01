// data/models/chat/chat_model.dart

class ChatModel {
  final String id;
  final Job job;
  final List<Participant> participants;
  final Message? lastMessage;
  final int unreadMessages;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatModel({
    required this.id,
    required this.job,
    required this.participants,
    this.lastMessage,
    required this.unreadMessages,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    id: json['_id'],
    job: Job.fromJson(json['jobId']),
    participants: (json['participants'] as List)
        .map((e) => Participant.fromJson(e))
        .toList(),
    lastMessage: json['lastMessage'] != null
        ? Message.fromJson(json['lastMessage'])
        : null,
    unreadMessages: json['unreadMessages'] ?? 0,
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
  );
}

class Job {
  final String id;
  final String title;

  Job({required this.id, required this.title});

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json['_id'],
    title: json['title'],
  );
}

class Participant {
  final User user;
  final String role;

  Participant({required this.user, required this.role});

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    user: User.fromJson(json['userId']),
    role: json['role'],
  );
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String profile;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['_id'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    profile: json['profile'],
  );
}

class Message {
  final String id;
  final String content;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.content,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json['_id'],
    content: json['content'],
    createdAt: DateTime.parse(json['createdAt']),
  );
}
