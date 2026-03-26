import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../../../../data/data_source/local/AuthPreferences.dart';
import '../../../../data/models/auth/fcm_token_req.dart';
import '../../../../data/models/auth/forget_pass_req.dart';
import '../../../../data/models/auth/login_req.dart';
import '../../../../data/models/auth/login_res.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/repository/auth_repository.dart';
import '../../../../utils/constants/colors.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository authRepository = AuthRepositoryImpl();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ── State ─────────────────────────────────────────────────────────────────

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  User? _currentUser;
  User? get currentUser => _currentUser;

  // ── Helpers ───────────────────────────────────────────────────────────────

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

    if (!_isValidEmail(emailController.text)) {
      _setError('Please enter a valid email address');
      _showErrorToast(_errorMessage);
      return false;
    }

    if (!_isValidPassword(passwordController.text)) {
      _setError('Password must be at least 6 characters');
      _showErrorToast(_errorMessage);
      return false;
    }

    final overlay = context.loaderOverlay;
    overlay.show();
    _setLoading(true);

    try {
      final response = await authRepository.login(LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text,
      ));

      // ✅ Set token on ApiClient so authenticated requests work

      await AuthPreferences.saveSession(
        token: response.token,
        user: response.user,
      );

      _currentUser = response.user;
      _isAuthenticated = true;
      _clearError();
      resetInputFields();
      notifyListeners();

      debugPrint('✅ Login: ${response.user.email} (${response.user.userType})');
      _showSuccessToast('Login successful');
      return true;

    } catch (error) {
      final msg = error.toString().replaceFirst('Exception: ', '');
      _setError(msg);
      _showErrorToast('Login failed: $msg');
      return false;

    } finally {
      overlay.hide();
      _setLoading(false);
    }
  }

  // ── Forgot Password ───────────────────────────────────────────────────────

  Future<bool> forgetPassword(BuildContext context) async {
    _clearError();

    if (!_isValidEmail(emailController.text)) {
      _setError('Please enter a valid email address');
      _showErrorToast(_errorMessage);
      return false;
    }

    final overlay = context.loaderOverlay;
    overlay.show();
    _setLoading(true);

    try {
      await authRepository.forgotPassword(
        ForgotPasswordRequest(email: emailController.text.trim()),
      );

      _clearError();
      resetInputFields();
      _showSuccessToast('Password reset link sent to your email');
      return true;

    } catch (error) {
      final msg = error.toString().replaceFirst('Exception: ', '');
      _setError(msg);
      _showErrorToast('Error: $msg');
      return false;

    } finally {
      overlay.hide();
      _setLoading(false);
    }
  }

  // ── Logout ────────────────────────────────────────────────────────────────

  Future<bool> logoutUser() async {
    _setLoading(true);

    try {
      // ✅ Call the actual logout endpoint
      await authRepository.logout();
    } catch (error) {
      debugPrint('⚠️ Logout API error (continuing anyway): $error');
    } finally {
      // ✅ Always clear session regardless of API result
      await AuthPreferences.clearSession();
      _isAuthenticated = false;
      _currentUser = null;
      _errorMessage = '';
      resetInputFields();
      _setLoading(false);
      notifyListeners();
    }

    _showSuccessToast('Logged out successfully');
    return true;
  }

  // ── FCM Token ─────────────────────────────────────────────────────────────

  Future<void> registerToken(String email, String token) async {
    try {
      await authRepository.registerFcmToken(FcmTokenRequest(
        email: email,
        fcmToken: token,
      ));
    } catch (e) {
      debugPrint('⚠️ FCM token registration failed: $e');
    }
  }

  // ── Profile ───────────────────────────────────────────────────────────────

  Future<void> getMe() async {
    _setLoading(true);

    try {
      _currentUser = await authRepository.getMe();
      _errorMessage = '';
      debugPrint('🟢 getMe: ${_currentUser?.toJson()}');
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('🔴 getMe error: $_errorMessage');
      _showErrorToast(_errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateProfile(UpdateProfileRequest request) async {
    _setLoading(true);

    try {
      _currentUser = await authRepository.updateProfile(request);
      _errorMessage = '';
      _showSuccessToast('Profile updated successfully');
    } catch (e) {
      _errorMessage = e.toString();
      _showErrorToast(_errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  // ── Misc ──────────────────────────────────────────────────────────────────

  void resetInputFields() {
    emailController.clear();
    passwordController.clear();
  }

  void _showSuccessToast(String message) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    textColor: Colors.white,
    fontSize: 16.0,
  );

  void _showErrorToast(String message) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: JAppColors.main.withValues(alpha: 0.8),
    textColor: Colors.white,
    fontSize: 16.0,
  );

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}