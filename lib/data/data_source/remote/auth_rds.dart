import 'package:flutter/cupertino.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/auth/login_req.dart';
import '../../models/auth/login_res.dart';

class AuthRemoteDataSource{
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);

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

}