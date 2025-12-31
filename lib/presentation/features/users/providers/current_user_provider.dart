import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/models/user/current_user_res.dart';
import '../../../../data/models/user/update_current_user_profile_req.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../domain/repository/user_repository.dart';
import '../../../../utils/constants/colors.dart';


class CurrentUserProvider with ChangeNotifier {
  final UserRepository _repository = UserRepositoryImpl();

  CurrentUser? _currentUser;
  bool _isLoading = false;
  String _errorMessage = '';

  CurrentUser? get currentUser => _currentUser;

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  // Future<void> fetchCurrentUser() async {
  //   _isLoading = true;
  //   _errorMessage = '';
  //   notifyListeners();
  //
  //   try {
  //     _currentUser = await _repository.getCurrentUser();
  //   } catch (e) {
  //     _errorMessage = e.toString();
  //     Fluttertoast.showToast(
  //       msg: _errorMessage,
  //       toastLength: Toast.LENGTH_LONG,
  //       backgroundColor: JAppColors.primary,
  //       textColor: Colors.white,
  //     );
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }


  Future<void> fetchCurrentUser() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final currentUser = await _repository.getCurrentUser();
      _currentUser = CurrentUser(
        name: currentUser.name ?? '',
        profile: currentUser.profile ?? '',
      );
      debugPrint('✅ Current user profile loaded successfully');
      debugPrint('📝 Full Name: ${_currentUser?.name}');
      debugPrint('🖼️ Profile Image: ${_currentUser?.profile}');
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('❌ Error fetching current user profile: $_errorMessage');

      // Show error toast only if there's a meaningful message
      if (_errorMessage.isNotEmpty && !_errorMessage.contains('null')) {
        Fluttertoast.showToast(
          msg: 'Failed to load profile: $_errorMessage',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: JAppColors.error900,
          textColor: Colors.white,
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear user profile
  void clearUserProfile() {
    _currentUser = null;
    _errorMessage = '';
    _isLoading = false;
    notifyListeners();
  }


  Future<bool> updateCurrentUserProfile(
      UpdateCurrentUserProfileRequest request) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      debugPrint('📤 Starting profile update...');
      debugPrint('Full Name: ${request.fullName}');
      debugPrint('Email: ${request.email}');
      debugPrint('DOB: ${request.dob}');
      debugPrint('Phone: ${request.phoneNumber}');
      debugPrint('Has Profile Picture: ${request.profilePicture != null}');

      // Call the repository to update profile
      final updatedUser = await _repository.updateCurrentUserProfile(request);

      // Update the local user data
      _currentUser = updatedUser;

      debugPrint('✅ Profile updated successfully');
      debugPrint('Updated Name: ${_currentUser?.name}');
      debugPrint('Updated Email: ${_currentUser?.email}');
      debugPrint('Updated Phone: ${_currentUser?.phoneNumber}');
      debugPrint('Updated Profile: ${_currentUser?.profile}');

      Fluttertoast.showToast(
        msg: "Profile updated successfully",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: JAppColors.primary,
        textColor: Colors.white,
      );

      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      debugPrint('❌ Error updating profile: $_errorMessage');

      Fluttertoast.showToast(
        msg: _errorMessage.isEmpty ? "Failed to update profile" : _errorMessage,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: JAppColors.error900,
        textColor: Colors.white,
      );

      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}