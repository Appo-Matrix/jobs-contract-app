import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_contracts/data/models/auth/forget_pass_req.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/constants/keys/secure_storage_keys.dart';
import '../../../../core/network/api_client.dart';
import '../../../../data/models/auth/fcm_token_req.dart';
import '../../../../data/models/auth/login_req.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/repository/auth_repository.dart';
import '../../../../domain/services/secure_storage_service.dart';

class AuthProvider with ChangeNotifier {

  final AuthRepository authRepository = AuthRepositoryImpl();
  final ApiClient _apiClient = ApiClient(ApiPath.baseUrl);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';
  bool _isAuthenticated = false;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;

  void updateEmail(String email) {
    emailController.text = email;
    notifyListeners();
  }

  void updatePassword(String password) {
    passwordController.text = password;
    notifyListeners();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.isNotEmpty && password.length >= 6;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  Future<bool> loginWithEmail(BuildContext context) async {
    _clearError();

    // Validate email
    if (emailController.text.isEmpty ||
        !_isValidEmail(emailController.text)) {
      _setError('Please enter a valid email address');
      _showErrorToast(_errorMessage);
      return false;
    }

    // Validate password
    if (!_isValidPassword(passwordController.text)) {
      _setError('Password must be at least 6 characters');
      _showErrorToast(_errorMessage);
      return false;
    }

    context.loaderOverlay.show();
    _setLoading(true);

    try {
      final loginRequest = LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final response = await authRepository.login(loginRequest);

      // ✅ FIXED: Use authToken (matches the key being used in logs)
      await SecureStorageService.save(
        SecureStorageKeys.authToken,
        response.token,
      );

      // Save to ApiClient's secure storage (for API requests)
      await _apiClient.saveToken(response.token);

      _isAuthenticated = true;
      _clearError();
      resetInputFields();
      notifyListeners();

      _showSuccessToast('Login successful');
      return true;

    } catch (error) {
      final errorMsg = error.toString();
      _setError(errorMsg);
      _showErrorToast(
        'Login failed: ${errorMsg.replaceFirst('Exception: ', '')}',
      );
      return false;

    } finally {
      context.loaderOverlay.hide();
      _setLoading(false);
    }
  }

  Future<bool> forgetPassword(BuildContext context) async {
    _clearError();

    if (emailController.text.isEmpty ||
        !_isValidEmail(emailController.text)) {
      _setError('Please enter a valid email address');
      _showErrorToast(_errorMessage);
      return false;
    }

    context.loaderOverlay.show();
    _setLoading(true);

    try {
      final forgetPassRequest = ForgotPasswordRequest(
        email: emailController.text.trim(),
      );

      await authRepository.forgotPassword(forgetPassRequest);

      _clearError();
      resetInputFields();
      notifyListeners();

      _showSuccessToast('Password reset link sent to your email');
      return true;

    } catch (error) {
      final errorMsg = error.toString();
      _setError(errorMsg);
      _showErrorToast(
        'Error: ${errorMsg.replaceFirst('Exception: ', '')}',
      );
      return false;

    } finally {
      context.loaderOverlay.hide();
      _setLoading(false);
    }
  }

  Future<bool> logoutUser(BuildContext context) async {
    _setLoading(true);

    try {
      final success = await authRepository.logout();
      if (success) {
        await SecureStorageService.deleteAll();
        // Also clear token from ApiClient
        await _apiClient.clearToken();

        _isAuthenticated = false;
        resetInputFields();
        notifyListeners();

        _showSuccessToast('Logout successful');
        return true;
      }
      return false;

    } catch (error) {
      final errorMsg = error.toString();
      _setError(errorMsg);
      _showErrorToast('Logout failed: $errorMsg');
      return false;

    } finally {
      _setLoading(false);
    }
  }

  void resetInputFields() {
    emailController.clear();
    passwordController.clear();
  }

  void _showSuccessToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: JAppColors.main.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> registerToken(String email, String token) async {
    _setLoading(true);

    try {
      final request = FcmTokenRequest(email: email, fcmToken: token);
      await authRepository.registerFcmToken(request);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}