import 'dart:io';
import 'package:dio/dio.dart';

class UpdateUserProfileRequest {
  final String fullName;
  final String email;
  final String? password;
  final File? profilePicture;

  UpdateUserProfileRequest({
    required this.fullName,
    required this.email,
    required this.password,
    required this.profilePicture,
  });

  // Standard JSON (not used for multipart)
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
    };
  }

  // FormData for Dio (multipart/form-data)
  Future<FormData> toFormData() async {
    final Map<String, dynamic> fields = {
      'fullName': fullName,
      'email': email,
    };

    if (password != null && password!.isNotEmpty) {
      fields['password'] = password;
    }

    if (profilePicture != null) {
      final fileName = profilePicture!.path.split('/').last;
      fields['profile'] = await MultipartFile.fromFile(
        profilePicture!.path,
        filename: fileName,
      );
    }

    return FormData.fromMap(fields);
  }
}
