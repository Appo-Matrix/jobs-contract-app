import 'dart:io';

class UploadResumeRequest {
  final String userId;
  final File resume;

  UploadResumeRequest({required this.userId, required this.resume});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
    };
  }
}
