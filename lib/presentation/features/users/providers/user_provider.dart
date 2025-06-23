// lib/providers/user_provider.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_contracts/data/repositories/user_repository_impl.dart';
import 'package:job_contracts/domain/repository/user_repository.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../data/models/user/update_user_profile_req.dart';


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

  Future<void> updateProfile(
      BuildContext context,
      String userId,
      UpdateUserProfileRequest request,
      ) async {
    try {
      context.loaderOverlay.show();
      _isLoading = true;
      notifyListeners();

      final response = await userRepository.updateUserProfile(userId, request);

      Fluttertoast.showToast(
        msg: "Profile updated: ${response.name}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    } finally {
      context.loaderOverlay.hide();
      _isLoading = false;
      notifyListeners();
    }
  }
}
