

class MessageModel {
  final String id;
  final String conversationId;  // ← was 'chatId'
  final String sender;          // ← new
  final String receiver;        // ← new
  final String text;            // ← was 'messageText'
  final List<MediaFile> images;
  final List<MediaFile> videos;
  final List<MediaFile> files;
  final List<MediaFile> audios;
  final bool isDelivered;
  final bool isRead;
  final DateTime? dateTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MessageModel({
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
    this.updatedAt,
  });

  /// Preview for conversation list
  String get preview {
    if (text.isNotEmpty) return text;
    if (images.isNotEmpty) return '📷 Image';
    if (videos.isNotEmpty) return '🎥 Video';
    if (files.isNotEmpty) return '📎 File';
    if (audios.isNotEmpty) return '🎵 Audio';
    return '';
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
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
    updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
  );
  MessageModel copyWith({
    String? id,
    String? conversationId,
    String? sender,
    String? receiver,
    String? text,
    List<MediaFile>? images,
    List<MediaFile>? videos,
    List<MediaFile>? files,
    List<MediaFile>? audios,
    bool? isDelivered,
    bool? isRead,
    DateTime? dateTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      text: text ?? this.text,
      images: images ?? this.images,
      videos: videos ?? this.videos,
      files: files ?? this.files,
      audios: audios ?? this.audios,
      isDelivered: isDelivered ?? this.isDelivered,
      isRead: isRead ?? this.isRead,
      dateTime: dateTime ?? this.dateTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  static List<MediaFile> _parseMedia(dynamic list) =>
      (list as List?)?.map((e) => MediaFile.fromJson(e)).toList() ?? [];

  Map<String, dynamic> toJson() => {
    'conversationId': conversationId,
    'receiverId': receiver,
    'text': text,
  };
}

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