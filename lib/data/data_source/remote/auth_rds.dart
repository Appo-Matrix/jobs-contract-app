import 'package:flutter/cupertino.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/auth/foget_pass_res.dart';
import '../../models/auth/forget_pass_req.dart';
import '../../models/auth/google_sigin_res.dart';
import '../../models/auth/google_signin_req.dart';
import '../../models/auth/login_req.dart';
import '../../models/auth/login_res.dart';
import '../../models/auth/register_user_req.dart';
import '../../models/auth/register_user_res.dart';
import '../../models/auth/reset_password_req.dart';
import '../../models/auth/reset_password_res.dart';
import '../../models/auth/send_otp_email_req.dart';
import '../../models/auth/send_otp_email_res.dart';
import '../../models/auth/send_otp_sms_req.dart';
import '../../models/auth/send_otp_sms_res.dart';
import '../../models/auth/update_password_req.dart';
import '../../models/auth/update_password_res.dart';

class AuthRemoteDataSource{
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  // Login
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await apiClient.post(
        endpoint: ApiPath.login,
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else if (response.statusCode == 400) {
        throw Exception('Invalid credentials or account issues');
      }else if(response.statusCode ==404 ) {
        throw Exception('User not  found');
      }else if(response.statusCode==500){
        throw Exception("Internal server error");
      } else {
        throw Exception(
            'Login failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Login error: $error');
      throw Exception('Error during login: $error');
    }
  }


  // Forget Password
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest request) async {
    try {
      final response = await apiClient.post(
        endpoint: ApiPath.forgotPassword,
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return ForgotPasswordResponse.fromJson(response.data);
      } else if (response.statusCode == 400) {
        throw Exception(ForgotPasswordError.fromJson(response.data).error);
      } else if (response.statusCode == 404) {
        throw Exception(ForgotPasswordError.fromJson(response.data).error);
      } else if (response.statusCode == 500) {
        final error = ForgotPasswordError.fromJson(response.data);
        throw Exception('${error.error}: ${error.details}');
      } else {
        throw Exception(
            'Forgot password failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Forgot password error: $error');
      throw Exception('Error during forgot password: $error');
    }
  }


  Future<RegisterUserResponse> registerUser(RegisterUserRequest request) async {
    try {
      final response = await apiClient.post(
        endpoint: ApiPath.register,
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        return RegisterUserResponse.fromJson(response.data);
      } else if (response.statusCode == 400 || response.statusCode == 409) {
        throw Exception(RegisterUserError.fromJson(response.data).error);
      } else if (response.statusCode == 500) {
        final error = RegisterUserError.fromJson(response.data);
        throw Exception('${error.error}');
      } else {
        throw Exception(
            'Registration failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Register user error: $error');
      throw Exception('Error during registration: $error');
    }
  }

  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) async {
    final response = await apiClient.put(
      endpoint: ApiPath.resetPassword ,
      data: request.toJson(),
    );

    if (response.statusCode == 200) {
      return ResetPasswordResponse.fromJson(response.data);
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      throw Exception(ResetPasswordError.fromJson(response.data).message);
    } else if (response.statusCode == 500) {
      final error = ResetPasswordError.fromJson(response.data);
      throw Exception('${error.message}: ${error.error}');
    } else {
      throw Exception(
        'Reset password failed with status code: ${response.statusCode}',
      );
    }
  }
  Future<SendOtpEmailResponse> sendOtpEmail(SendOtpEmailRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.sendOtpEmail,
      data: request.toJson(),
    );

    if (response.statusCode == 200) {
      return SendOtpEmailResponse.fromJson(response.data);
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      throw Exception(SendOtpEmailError.fromJson(response.data).message);
    } else if (response.statusCode == 500) {
      final error = SendOtpEmailError.fromJson(response.data);
      throw Exception('${error.message}: ${error.error}');
    } else {
      throw Exception(
        'OTP request failed with status code: ${response.statusCode}',
      );
    }
  }

  Future<SendOtpSmsResponse> sendOtpSms(SendOtpSmsRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.sendOtpSms,
      data: request.toJson(),
    );

    if (response.statusCode == 200) {
      return SendOtpSmsResponse.fromJson(response.data);
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      throw Exception(SendOtpSmsError.fromJson(response.data).message);
    } else if (response.statusCode == 500) {
      final error = SendOtpSmsError.fromJson(response.data);
      throw Exception('${error.message}: ${error.error}');
    } else {
      throw Exception(
        'OTP SMS request failed with status code: ${response.statusCode}',
      );
    }
  }
  @override
  Future<GoogleSignInResponse> signInWithGoogle(GoogleSignInRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.googleSignIn,
      data: request.toJson(),
    );

    if (response.statusCode == 200) {
      return GoogleSignInResponse.fromJson(response.data);
    } else if (response.statusCode == 400 || response.statusCode == 500) {
      throw Exception('Google sign-in failed: ${response.data['message'] ?? 'Unknown error'}');
    } else {
      throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  @override
  Future<UpdatePasswordResponse> updatePassword(UpdatePasswordRequest request) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updatePassword,
      data: request.toJson(),
    );

    if (response.statusCode == 200) {
      return UpdatePasswordResponse.fromJson(response.data);
    } else if ([400, 401, 404].contains(response.statusCode)) {
      throw Exception(UpdatePasswordError.fromJson(response.data).error);
    } else if (response.statusCode == 500) {
      final error = UpdatePasswordError.fromJson(response.data);
      throw Exception('${error.error}: ${error.details}');
    } else {
      throw Exception('Unexpected error: ${response.statusCode}');
    }
  }
  Future<bool> logout() async {
    final response = await apiClient.post(endpoint: ApiPath.logout);

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized: Token missing or invalid.");
    } else if (response.statusCode == 404) {
      throw Exception("User not found.");
    } else if (response.statusCode == 500) {
      throw Exception("Internal Server Error.");
    } else {
      throw Exception("Logout failed with status code: ${response.statusCode}");
    }
  }




}