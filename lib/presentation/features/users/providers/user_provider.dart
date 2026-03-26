// lib/providers/user_provider.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../data/models/auth/login_res.dart';
import '../../../../data/models/user/update_user_profile_req.dart';
import '../../../../data/models/user/upload_resume_req.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../domain/repository/user_repository.dart';
import '../../../../utils/constants/colors.dart';


class UserProvider extends ChangeNotifier {
  final UserRepository userRepository  = UserRepositoryImpl();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;


  Future<void> deleteResume(BuildContext context) async {
    context.loaderOverlay.show();
    _isLoading = true;
    notifyListeners();

    try {

      final response = await userRepository.deleteResume();
      if (response.success) {
        Fluttertoast.showToast(
          msg: "Resume deleted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (error) {
      _errorMessage = 'Error: $error';
      Fluttertoast.showToast(
        msg: 'Failed to delete resume: $error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.red,
        fontSize: 16.0,
      );
    } finally {
      context.loaderOverlay.hide();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteUserById(BuildContext context, String userId) async {
    context.loaderOverlay.show();
    _isLoading = true;
    notifyListeners();

    try {
      final response = await userRepository.deleteUser(userId);
      Fluttertoast.showToast(
        msg: response.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (error) {
      _errorMessage = 'Error: $error';
      Fluttertoast.showToast(
        msg: _errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.red,
        fontSize: 16.0,
      );
    } finally {
      context.loaderOverlay.hide();
      _isLoading = false;
      notifyListeners();
    }
  }



  Future<void> uploadResume({
    required BuildContext context,
    required String userId,
    required File resumeFile,
  }) async {
    context.loaderOverlay.show();
    _isLoading = true;
    notifyListeners();

    try {
      final req = UploadResumeRequest(userId: userId, resume: resumeFile);
      final response = await userRepository.uploadResume(req);

      Fluttertoast.showToast(
        msg: response.message,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(
        msg: "Upload failed: $_errorMessage",
        gravity: ToastGravity.CENTER,
        backgroundColor: JAppColors.error900,
        textColor: Colors.white,
      );
    } finally {
      context.loaderOverlay.hide();
      _isLoading = false;
      notifyListeners();
    }
  }





}
