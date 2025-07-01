import 'dart:io';
import 'package:dio/dio.dart';

class UpdateCurrentUserProfileRequest {
  final String name;
  final String email;
  final String? password;
  final File? profilePicture;

  UpdateCurrentUserProfileRequest({
    required this.name,
    required this.email,
    this.password,
    this.profilePicture,
  });

  Future<FormData> toFormData() async {
    final formData = FormData();

    formData.fields
      ..add(MapEntry('name', name))
      ..add(MapEntry('email', email));

    if (password != null && password!.isNotEmpty) {
      formData.fields.add(MapEntry('password', password!));
    }

    if (profilePicture != null) {
      formData.files.add(MapEntry(
        'profile',
        await MultipartFile.fromFile(
          profilePicture!.path,
          filename: profilePicture!.path.split('/').last,
        ),
      ));
    }

    return formData;
  }
}
