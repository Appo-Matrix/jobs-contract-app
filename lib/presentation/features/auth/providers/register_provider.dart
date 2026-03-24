import 'package:flutter/material.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../../../../data/data_source/local/AuthPreferences.dart';
import '../../../../data/models/auth/register_user_req.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/repository/auth_repository.dart';

class RegisterProvider with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepositoryImpl();
  final ApiClient _apiClient = ApiClient(ApiPath.baseUrl);

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userTypeController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';
  double? _latitude;
  double? _longitude;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  double? get latitude => _latitude;
  double? get longitude => _longitude;

  // ── Helpers ───────────────────────────────────────────────────────────────

  void setLocation(double latitude, double longitude) {
    _latitude = latitude;
    _longitude = longitude;
    notifyListeners();
    debugPrint('📍 Location set: latitude=$latitude, longitude=$longitude');
  }

  void updateEmail(String email) {
    emailController.text = email;
    notifyListeners();
  }

  // ── Register ──────────────────────────────────────────────────────────────

  Future<void> registerUser() async {
    if (!_validateInputs()) {
      throw Exception(_errorMessage);
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      debugPrint('🔐 Creating registration request:');
      debugPrint('   fullName    : ${fullNameController.text}');
      debugPrint('   email       : ${emailController.text}');
      debugPrint('   phoneNumber : ${phoneNumberController.text}');
      debugPrint('   userType    : ${userTypeController.text}');
      debugPrint('   location    : ($_latitude, $_longitude)');

      final request = RegisterUserRequest(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        userType: userTypeController.text.trim(),
        password: passwordController.text,
        location: Location(
          type: 'Point',
          coordinates: [_longitude ?? 0.0, _latitude ?? 0.0],
        ),
      );

      debugPrint('📡 API Request Payload: ${request.toJson()}');

      final response = await _authRepository.registerUser(request);



      debugPrint('✅ Registration successful: ${response.message}');
      resetFields();

    } catch (error) {
      String message = error
          .toString()
          .replaceAll('Exception: ', '')
          .replaceAll('Error: ', '');

      if (message.contains('Unknown error') || message.isEmpty) {
        message = 'Registration failed. Please try again.';
      }

      _errorMessage = message;
      debugPrint('❌ Registration error: $message');
      _isLoading = false;
      notifyListeners();
      throw Exception(message); // rethrow so caller can show dialog

    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ── Validation ────────────────────────────────────────────────────────────

  bool _validateInputs() {
    debugPrint('🔍 Validating RegisterProvider inputs:');
    debugPrint('   fullName    : ${fullNameController.text}');
    debugPrint('   email       : ${emailController.text}');
    debugPrint('   phoneNumber : ${phoneNumberController.text}');
    debugPrint('   password    : ${passwordController.text}');
    debugPrint('   userType    : ${userTypeController.text}');
    debugPrint('   location    : ($_latitude, $_longitude)');

    if (fullNameController.text.trim().isEmpty) {
      _errorMessage = 'Please enter full name';
      return false;
    }

    if (emailController.text.trim().isEmpty ||
        !_isValidEmail(emailController.text.trim())) {
      _errorMessage = 'Please enter valid email';
      return false;
    }

    if (phoneNumberController.text.trim().isEmpty) {
      _errorMessage = 'Please enter phone number';
      return false;
    }

    if (passwordController.text.isEmpty ||
        passwordController.text.length < 6) {
      _errorMessage = 'Password must be at least 6 characters';
      return false;
    }

    if (userTypeController.text.trim().isEmpty) {
      _errorMessage = 'Please select user type';
      return false;
    }

    if (_latitude == null || _longitude == null) {
      _errorMessage = 'Please select location';
      return false;
    }

    debugPrint('✅ All validations passed!');
    return true;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(email);
  }

  // ── Misc ──────────────────────────────────────────────────────────────────

  void resetFields() {
    fullNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    passwordController.clear();
    userTypeController.clear();
    _latitude = null;
    _longitude = null;
    notifyListeners();
    debugPrint('🔄 All fields reset');
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    userTypeController.dispose();
    super.dispose();
  }
}