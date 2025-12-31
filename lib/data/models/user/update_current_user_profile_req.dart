import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

class UpdateCurrentUserProfileRequest {
  final String fullName;
  final String email;
  final String? dob;
  final String? phoneNumber;
  final File? profilePicture;

  UpdateCurrentUserProfileRequest({
    required this.fullName,
    required this.email,
    this.dob,
    this.phoneNumber,
    this.profilePicture,
  });

  // For JSON request (without image)
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      if (dob != null && dob!.isNotEmpty) 'dob': dob,
      if (phoneNumber != null && phoneNumber!.isNotEmpty) 'phoneNumber': phoneNumber,
    };
  }

  // For FormData request (with image)
  Future<FormData> toFormData() async {
    debugPrint('');
    debugPrint('═══════════════════════════════════════');
    debugPrint('🔧 Building FormData for Profile Update');
    debugPrint('═══════════════════════════════════════');

    final formData = FormData();

    // Add required fields
    formData.fields.add(MapEntry('fullName', fullName));
    formData.fields.add(MapEntry('email', email));

    debugPrint('✅ Required fields:');
    debugPrint('   fullName: $fullName');
    debugPrint('   email: $email');

    // Add optional fields
    if (dob != null && dob!.isNotEmpty) {
      formData.fields.add(MapEntry('dob', dob!));
      debugPrint('✅ Optional field - dob: $dob');
    }

    if (phoneNumber != null && phoneNumber!.isNotEmpty) {
      formData.fields.add(MapEntry('phoneNumber', phoneNumber!));
      debugPrint('✅ Optional field - phoneNumber: $phoneNumber');
    }

    // Add profile picture
    if (profilePicture != null) {
      final exists = await profilePicture!.exists();
      debugPrint('');
      debugPrint('📸 Profile Picture Details:');
      debugPrint('   Path: ${profilePicture!.path}');
      debugPrint('   Exists: $exists');

      if (exists) {
        final fileSize = await profilePicture!.length();
        final fileName = profilePicture!.path.split('/').last;
        final extension = fileName.split('.').last.toLowerCase();

        debugPrint('   Size: ${(fileSize / 1024).toStringAsFixed(2)} KB');
        debugPrint('   Filename: $fileName');
        debugPrint('   Extension: $extension');

        // Determine MIME type
        MediaType? mediaType;
        if (extension == 'jpg' || extension == 'jpeg') {
          mediaType = MediaType('image', 'jpeg');
        } else if (extension == 'png') {
          mediaType = MediaType('image', 'png');
        } else if (extension == 'gif') {
          mediaType = MediaType('image', 'gif');
        } else if (extension == 'webp') {
          mediaType = MediaType('image', 'webp');
        }

        debugPrint('   MIME Type: ${mediaType?.mimeType ?? "not set"}');

        try {
          final multipartFile = await MultipartFile.fromFile(
            profilePicture!.path,
            filename: fileName,
            contentType: mediaType,
          );

          formData.files.add(MapEntry('profile', multipartFile));
          debugPrint('✅ Profile picture added to FormData successfully');
        } catch (e) {
          debugPrint('❌ Error creating MultipartFile: $e');
        }
      } else {
        debugPrint('❌ File does not exist at path!');
      }
    } else {
      debugPrint('ℹ️  No profile picture provided');
    }

    debugPrint('');
    debugPrint('📦 Final FormData Summary:');
    debugPrint('   Total fields: ${formData.fields.length}');
    for (var field in formData.fields) {
      debugPrint('   - ${field.key}: ${field.value}');
    }
    debugPrint('   Total files: ${formData.files.length}');
    for (var file in formData.files) {
      debugPrint('   - ${file.key}: ${file.value.filename} (${file.value.length} bytes)');
    }
    debugPrint('═══════════════════════════════════════');
    debugPrint('');

    return formData;
  }
}