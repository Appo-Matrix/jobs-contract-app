import 'package:flutter/cupertino.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/auth/foget_pass_res.dart';
import '../../models/auth/forget_pass_req.dart';
import '../../models/auth/login_req.dart';
import '../../models/auth/login_res.dart';
import '../../models/auth/register_user_req.dart';
import '../../models/auth/register_user_res.dart';

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




}