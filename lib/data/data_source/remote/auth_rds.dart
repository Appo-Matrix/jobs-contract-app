  import 'package:flutter/cupertino.dart';

  import '../../../core/constants/api_endpoints.dart';
  import '../../../core/network/api_client.dart';
  import '../../models/auth/fcm_token_req.dart';
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

  class AuthRemoteDataSource {
    final ApiClient apiClient = ApiClient(ApiPath.baseUrl);

    // Login
   // Login
    Future<LoginResponse> login(LoginRequest request) async {
      try {
        debugPrint('📤 Login Request: ${request.toJson()}');

        final response = await apiClient.post(
          endpoint: ApiPath.login,
          data: request.toJson(),
        );

        debugPrint('📥 Login Response received:');
        debugPrint('   Status Code: ${response.statusCode}');
        debugPrint('   Data Type: ${response.data.runtimeType}');
        debugPrint('   Full Data: ${response.data}');

        if (response.statusCode == 200) {
          try {
            final loginResponse = LoginResponse.fromJson(response.data);
            debugPrint('✅ Login successful');
            return loginResponse;
          } catch (parseError) {
            debugPrint('❌ Error parsing LoginResponse: $parseError');
            debugPrint('   Response data: ${response.data}');
            rethrow;
          }
        } else if (response.statusCode == 400) {
          throw Exception('Invalid credentials or account issues');
        } else if (response.statusCode == 404) {
          throw Exception('User not found');
        } else if (response.statusCode == 500) {
          throw Exception("Internal server error");
        } else {
          throw Exception(
              'Login failed with status code: ${response.statusCode}');
        }
      } catch (error) {
        debugPrint('❌ Login error: $error');
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

    // Register User
    Future<RegisterUserResponse> registerUser(RegisterUserRequest request) async {
      try {
        debugPrint('📤 AuthRemoteDataSource: Registering user');
        debugPrint('   Request: ${request.toJson()}');

        final response = await apiClient.post(
          endpoint: ApiPath.register,
          data: request.toJson(),
        );

        debugPrint('📥 Registration Response received:');
        debugPrint('   Status Code: ${response.statusCode}');
        debugPrint('   Data: ${response.data}');

        // Accept both 200 and 201 as success
        if (response.statusCode == 200 || response.statusCode == 201) {
          // Handle null response data
          if (response.data == null) {
            debugPrint('⚠️ Response data is null, creating default success response');
            return RegisterUserResponse(
              message: 'Account created successfully',
              success: true,
              data: null,
            );
          }

          // Parse the response
          try {
            final result = RegisterUserResponse.fromJson(response.data);
            debugPrint('✅ Registration successful: ${result.message}');
            return result;
          } catch (e) {
            debugPrint('⚠️ Error parsing response, returning default success');
            return RegisterUserResponse(
              message: 'Account created successfully',
              success: true,
              data: response.data,
            );
          }
        } else if (response.statusCode == 400 || response.statusCode == 409) {
          debugPrint('❌ Registration failed: ${response.data}');
          try {
            final error = RegisterUserError.fromJson(response.data);
            throw Exception(error.error);
          } catch (e) {
            throw Exception('Registration failed: ${response.data['message'] ?? 'Unknown error'}');
          }
        } else if (response.statusCode == 500) {
          debugPrint('❌ Server error: ${response.data}');
          try {
            final error = RegisterUserError.fromJson(response.data);
            throw Exception(error.error);
          } catch (e) {
            throw Exception('Server error: ${response.data['message'] ?? 'Internal server error'}');
          }
        } else {
          throw Exception(
              'Registration failed with status code: ${response.statusCode}');
        }
      } on Exception catch (error) {
        debugPrint('❌ Registration Exception: $error');
        rethrow;
      } catch (error) {
        debugPrint('❌ Unexpected registration error: $error');
        throw Exception('Error during registration: $error');
      }
    }

    // Reset Password
    Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) async {
      final response = await apiClient.put(
        endpoint: ApiPath.resetPassword,
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

    // Send OTP Email
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

    // Send OTP SMS
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

    // Google Sign In
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

    // Update Password
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

    // Logout
    Future<bool> logout() async {
      try {
        debugPrint('📤 Logout URL: ${ApiPath.baseUrl}${ApiPath.logout}');

        final response = await apiClient.post(endpoint: ApiPath.logout);

        debugPrint('📥 Logout status: ${response.statusCode}');
        debugPrint('📥 Logout headers sent: ${response.requestOptions.headers}'); // ← add this
        debugPrint('📥 Logout body: ${response.data}');

        return true; // ✅ always logout locally

      } catch (e) {
        debugPrint('⚠️ Logout error: $e');
        return true; // ✅ always logout locally
      }
    }
    Future<void> registerFcmToken(FcmTokenRequest request) async {
      try {
        final response = await apiClient.post(
          endpoint: ApiPath.registerFcmToken,
          data: request.toJson(),
        );

        if (response.statusCode == 200) {
          debugPrint('✅ FCM token registered');
          return;
        } else {
          // ✅ Just log — don't throw, don't block logout or navigation
          debugPrint('⚠️ FCM token registration failed: ${response.statusCode} — ${response.data}');
        }
      } catch (e) {
        // ✅ Silently ignore — FCM failure should never affect auth flow
        debugPrint('⚠️ FCM token error (ignored): $e');
      }
    }




    Future<User> getMe() async {
      final response = await apiClient.get(
        ApiPath.me, // e.g. '/users/me'
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception(response.data['message'] ?? 'Unauthorized');
      } else {
        throw Exception(response.data['error'] ?? 'Unexpected error occurred');
      }
    }


    Future<User> updateProfile(UpdateProfileRequest request) async {
      final response = await apiClient.put(
        endpoint: ApiPath.me, // PATCH/PUT '/users/me'
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw Exception(response.data['message'] ?? response.data['errors']?.join(', '));
      } else {
        throw Exception(response.data['error'] ?? 'Unexpected error occurred');
      }
    }


  }


