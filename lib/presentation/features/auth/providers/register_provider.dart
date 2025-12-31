import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:job_contracts/utils/constants/colors.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/constants/keys/secure_storage_keys.dart';
import '../../../../core/network/api_client.dart';
import '../../../../data/models/auth/register_user_req.dart';
import '../../../../domain/repository/auth_repository.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/services/secure_storage_service.dart';

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

  Future<void> registerUser(BuildContext context) async {
    if (!_validateInputs()) {
      Fluttertoast.showToast(
        msg: _errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      notifyListeners();
      return;
    }

    context.loaderOverlay.show();
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      debugPrint('🔐 Creating registration request with:');
      debugPrint('   fullName: ${fullNameController.text}');
      debugPrint('   email: ${emailController.text}');
      debugPrint('   phoneNumber: ${phoneNumberController.text}');
      debugPrint('   userType: ${userTypeController.text}');
      debugPrint('   location: ($_latitude, $_longitude)');

      final request = RegisterUserRequest(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        userType: userTypeController.text.trim(),
        password: passwordController.text,
        location: Location(
          type: "Point",
          coordinates: [_longitude ?? 0.0, _latitude ?? 0.0],
        ),
      );

      debugPrint('📡 API Request Payload: ${request.toJson()}');

      final response = await _authRepository.registerUser(request);

      // Save token if the registration response includes one
      if (response.token != null && response.token!.isNotEmpty) {
        // Save to SecureStorageService
        await SecureStorageService.save(
          SecureStorageKeys.authToken,
          response.token!,
        );

        // Save to ApiClient's secure storage
        await _apiClient.saveToken(response.token!);

        debugPrint('✅ Token saved successfully');
      }

      debugPrint('✅ Registration successful: ${response.message}');

      Fluttertoast.showToast(
        msg: response.message ?? 'Account created successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (error) {
      _errorMessage = 'Error: $error';
      debugPrint('❌ Registration error: $_errorMessage');

      Fluttertoast.showToast(
        msg: 'Something went wrong => $_errorMessage',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: JAppColors.white,
        fontSize: 16.0,
      );
    } finally {
      context.loaderOverlay.hide();
      _isLoading = false;
      notifyListeners();
    }

    resetFields();
  }

  bool _validateInputs() {
    debugPrint('🔍 Validating RegisterProvider inputs:');
    debugPrint('   fullName: ${fullNameController.text}');
    debugPrint('   email: ${emailController.text}');
    debugPrint('   phoneNumber: ${phoneNumberController.text}');
    debugPrint('   password: ${passwordController.text}');
    debugPrint('   userType: ${userTypeController.text}');
    debugPrint('   latitude: $_latitude, longitude: $_longitude');

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

    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
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