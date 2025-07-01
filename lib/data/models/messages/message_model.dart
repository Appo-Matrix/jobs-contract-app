class MessageMedia {
  final String fileType;
  final String fileUrl;
  final String fileName;

  MessageMedia({
    required this.fileType,
    required this.fileUrl,
    required this.fileName,
  });

  factory MessageMedia.fromJson(Map<String, dynamic> json) {
    return MessageMedia(
      fileType: json['fileType'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
      fileName: json['fileName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileType': fileType,
      'fileUrl': fileUrl,
      'fileName': fileName,
    };
  }
}

class MessageModel {
  final String id;
  final String chatId;
  final String? messageText;
  final List<MessageMedia>? media;
  final DateTime? timestamp;
  final bool readStatus;

  MessageModel({
    required this.id,
    required this.chatId,
    this.messageText,
    this.media,
    this.timestamp,
    this.readStatus = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'] ?? '',
      chatId: json['chatId'] ?? '',
      messageText: json['messageText'],
      media: (json['media'] as List?)?.map((e) => MessageMedia.fromJson(e)).toList(),
      timestamp: json['timestamp'] != null ? DateTime.tryParse(json['timestamp']) : null,
      readStatus: json['readStatus'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'chatId': chatId,
      if (messageText != null) 'messageText': messageText,
      if (media != null) 'media': media!.map((e) => e.toJson()).toList(),
      if (timestamp != null) 'timestamp': timestamp!.toIso8601String(),
      'readStatus': readStatus,
    };
  }
}
