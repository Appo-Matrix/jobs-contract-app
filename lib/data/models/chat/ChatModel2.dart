// data/models/chat/chat_model.dart

class ChatModel2 {
  final String id;
  final List<String> members;
  final OtherUser otherUser;
  final LastMessage? lastMessage;
  final int unreadCount;
  final bool isOnline;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatModel2({
    required this.id,
    required this.members,
    required this.otherUser,
    this.lastMessage,
    required this.unreadCount,
    required this.isOnline,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatModel2.fromJson(Map<String, dynamic> json) => ChatModel2(
    id: json['_id'] ?? '',
    members: json['members'] != null
        ? List<String>.from(json['members'])
        : [],
    otherUser: OtherUser.fromJson(json['otherUser'] ?? {}),
    lastMessage: json['lastMessage'] != null && json['lastMessage'] is Map
        ? LastMessage.fromJson(json['lastMessage'])
        : null,
    unreadCount: json['unreadCount'] ?? 0,
    isOnline: json['isOnline'] ?? false,
    createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
  );
}

// ── Other User ────────────────────────────────────────────────────
class OtherUser {
  final String id;
  final String fullName;
  final String profile;
  final bool isOnline;

  OtherUser({
    required this.id,
    required this.fullName,
    required this.profile,
    required this.isOnline,
  });

  factory OtherUser.fromJson(Map<String, dynamic> json) => OtherUser(
    id: json['_id'] ?? '',
    fullName: json['fullName'] ?? '',
    profile: json['profile'] ?? '',
    isOnline: json['isOnline'] ?? false,
  );
}

// ── Last Message ──────────────────────────────────────────────────
class LastMessage {
  final String id;
  final String conversationId;
  final String sender;
  final String receiver;
  final String text;
  final List<MediaFile> images;
  final List<MediaFile> videos;
  final List<MediaFile> files;
  final List<MediaFile> audios;
  final bool isDelivered;
  final bool isRead;
  final DateTime? dateTime;
  final DateTime? createdAt;

  LastMessage({
    required this.id,
    required this.conversationId,
    required this.sender,
    required this.receiver,
    required this.text,
    required this.images,
    required this.videos,
    required this.files,
    required this.audios,
    required this.isDelivered,
    required this.isRead,
    this.dateTime,
    this.createdAt,
  });

  /// Preview text shown in conversation list
  String get preview {
    if (text.isNotEmpty) return text;
    if (images.isNotEmpty) return '📷 Image';
    if (videos.isNotEmpty) return '🎥 Video';
    if (files.isNotEmpty) return '📎 File';
    if (audios.isNotEmpty) return '🎵 Audio';
    return '';
  }

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    id: json['_id'] ?? '',
    conversationId: json['conversationId'] ?? '',
    sender: json['sender'] ?? '',
    receiver: json['receiver'] ?? '',
    text: json['text'] ?? '',
    images: _parseMedia(json['images']),
    videos: _parseMedia(json['videos']),
    files: _parseMedia(json['files']),
    audios: _parseMedia(json['audios']),
    isDelivered: json['isDelivered'] ?? false,
    isRead: json['isRead'] ?? false,
    dateTime: DateTime.tryParse(json['dateTime'] ?? ''),
    createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
  );

  static List<MediaFile> _parseMedia(dynamic list) =>
      (list as List?)?.map((e) => MediaFile.fromJson(e)).toList() ?? [];
}

// ── Media File ────────────────────────────────────────────────────
class MediaFile {
  final String url;
  final String publicId;
  final int size;
  final String mimeType;

  MediaFile({
    required this.url,
    required this.publicId,
    required this.size,
    required this.mimeType,
  });

  factory MediaFile.fromJson(Map<String, dynamic> json) => MediaFile(
    url: json['url'] ?? '',
    publicId: json['publicId'] ?? '',
    size: json['size'] ?? 0,
    mimeType: json['mimeType'] ?? '',
  );
}