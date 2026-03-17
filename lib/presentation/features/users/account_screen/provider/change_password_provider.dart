import 'dart:developer';
import 'package:flutter/material.dart';

import '../repos/change_password_repository.dart';

enum ChangePasswordStatus { idle, loading, success, error }

class ChangePasswordProvider extends ChangeNotifier {
  final ChangePasswordRepository _repository;

  ChangePasswordProvider(this._repository);

  // ─── State ───────────────────────────────────────────────────────────────
  ChangePasswordStatus _status = ChangePasswordStatus.idle;
  String _errorMessage = '';
  String _successMessage = '';

  // ─── Password visibility toggles ────────────────────────────────────────
  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isRetypePasswordVisible = false;

  // ─── Form controllers ────────────────────────────────────────────────────
  final TextEditingController currentPasswordController =
  TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController retypePasswordController =
  TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ─── Getters ─────────────────────────────────────────────────────────────
  ChangePasswordStatus get status => _status;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;
  bool get isLoading => _status == ChangePasswordStatus.loading;
  bool get isCurrentPasswordVisible => _isCurrentPasswordVisible;
  bool get isNewPasswordVisible => _isNewPasswordVisible;
  bool get isRetypePasswordVisible => _isRetypePasswordVisible;

  // ─── Toggle visibility ───────────────────────────────────────────────────
  void toggleCurrentPasswordVisibility() {
    _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _isNewPasswordVisible = !_isNewPasswordVisible;
    notifyListeners();
  }

  void toggleRetypePasswordVisibility() {
    _isRetypePasswordVisible = !_isRetypePasswordVisible;
    notifyListeners();
  }

  // ─── Validation ──────────────────────────────────────────────────────────
  String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Current password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'New password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (value == currentPasswordController.text) {
      return 'New password must be different from current password';
    }
    return null;
  }

  String? validateRetypePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please retype your new password';
    }
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // ─── Change password action ──────────────────────────────────────────────
  Future<bool> changePassword() async {
    if (!formKey.currentState!.validate()) return false;

    _setStatus(ChangePasswordStatus.loading);

    try {
      final response = await _repository.changePassword(
        oldPassword: currentPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
      );

      if (response.success) {
        _successMessage = response.message;
        _setStatus(ChangePasswordStatus.success);
        _clearControllers();
        log('✅ Password changed successfully');
        return true;
      } else {
        _errorMessage = response.message;
        _setStatus(ChangePasswordStatus.error);
        log('❌ Change password failed: $_errorMessage');
        return false;
      }
    } catch (e) {
      _errorMessage = 'An unexpected error occurred.';
      _setStatus(ChangePasswordStatus.error);
      log('❌ Unexpected error in changePassword provider: $e');
      return false;
    }
  }

  // ─── Reset state ─────────────────────────────────────────────────────────
  void resetState() {
    _status = ChangePasswordStatus.idle;
    _errorMessage = '';
    _successMessage = '';
    notifyListeners();
  }

  // ─── Helpers ─────────────────────────────────────────────────────────────
  void _setStatus(ChangePasswordStatus status) {
    _status = status;
    notifyListeners();
  }

  void _clearControllers() {
    currentPasswordController.clear();
    newPasswordController.clear();
    retypePasswordController.clear();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    retypePasswordController.dispose();
    super.dispose();
  }
}