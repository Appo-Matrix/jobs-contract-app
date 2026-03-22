import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../../../../data/data_source/local/AuthPreferences.dart';
import '../../../../data/models/auth/fcm_token_req.dart';
import '../../../../data/models/auth/forget_pass_req.dart';
import '../../../../data/models/auth/login_req.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/repository/auth_repository.dart';
import '../../../../utils/constants/colors.dart';

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

  // ── Helpers ───────────────────────────────────────────────────────────────

  void updateEmail(String email) {
    emailController.text = email;
    notifyListeners();
  }

  void updatePassword(String password) {
    passwordController.text = password;
    notifyListeners();
  }

  bool _isValidEmail(String email) =>
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
          .hasMatch(email);

  bool _isValidPassword(String password) =>
      password.isNotEmpty && password.length >= 6;

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

  // ── Login ─────────────────────────────────────────────────────────────────

  Future<bool> loginWithEmail(BuildContext context) async {
    _clearError();

    if (emailController.text.isEmpty || !_isValidEmail(emailController.text)) {
      _setError('Please enter a valid email address');
      _showErrorToast(_errorMessage);
      return false;
    }

    if (!_isValidPassword(passwordController.text)) {
      _setError('Password must be at least 6 characters');
      _showErrorToast(_errorMessage);
      return false;
    }

    // Capture overlay before async gap to avoid BuildContext warning
    final overlay = context.loaderOverlay;
    overlay.show();
    _setLoading(true);

    try {
      final loginRequest = LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final response = await authRepository.login(loginRequest);

      // Save token to ApiClient for outgoing requests
      await _apiClient.saveToken(response.token);

      // Save full session (token + user) via AuthPreferences
      await AuthPreferences.saveSession(
        token: response.token,
        user: response.user,
      );

      debugPrint('✅ Session saved: ${response.user.email}');
      debugPrint('   userType : ${response.user.userType}');
      debugPrint('   token    : ${response.token.substring(0, 20)}...');

      _isAuthenticated = true;
      _clearError();
      resetInputFields();
      notifyListeners();

      _showSuccessToast('Login successful');
      return true;

    } catch (error) {
      final errorMsg = error.toString().replaceFirst('Exception: ', '');
      _setError(errorMsg);
      _showErrorToast('Login failed: $errorMsg');
      return false;

    } finally {
      overlay.hide();
      _setLoading(false);
    }
  }

  // ── Forgot Password ───────────────────────────────────────────────────────

  Future<bool> forgetPassword(BuildContext context) async {
    _clearError();

    if (emailController.text.isEmpty || !_isValidEmail(emailController.text)) {
      _setError('Please enter a valid email address');
      _showErrorToast(_errorMessage);
      return false;
    }

    // Capture overlay before async gap to avoid BuildContext warning
    final overlay = context.loaderOverlay;
    overlay.show();
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
      final errorMsg = error.toString().replaceFirst('Exception: ', '');
      _setError(errorMsg);
      _showErrorToast('Error: $errorMsg');
      return false;

    } finally {
      overlay.hide();
      _setLoading(false);
    }
  }

  // ── Logout ────────────────────────────────────────────────────────────────

  // No BuildContext needed — overlay not used during logout
  Future<bool> logoutUser() async {
    _setLoading(true);

    try {
      final success = await authRepository.logout();
      if (success) {
        await _apiClient.clearToken();
        await AuthPreferences.clearSession();

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

  // ── FCM Token ─────────────────────────────────────────────────────────────

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

  // ── Misc ──────────────────────────────────────────────────────────────────

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
      backgroundColor: JAppColors.main.withValues(alpha: 0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}