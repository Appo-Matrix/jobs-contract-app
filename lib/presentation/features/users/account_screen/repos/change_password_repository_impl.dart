import 'dart:developer';
import 'package:dio/dio.dart';
import '../models/change_password_model.dart';
import 'change_password_repository.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final Dio _dio;
  final String _updatePasswordEndpoint;

  ChangePasswordRepositoryImpl({
    required Dio dio,
    required String updatePasswordEndpoint,
  })  : _dio = dio,
        _updatePasswordEndpoint = updatePasswordEndpoint;

  @override
  Future<ChangePasswordResponseModel> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final requestModel = ChangePasswordModel(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      log('🔐 Sending change password request to $_updatePasswordEndpoint');

      final response = await _dio.put(
        _updatePasswordEndpoint,
        data: requestModel.toJson(),
      );

      log('✅ Change password response: ${response.statusCode} - ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ChangePasswordResponseModel(
          success: true,
          message: response.data['message'] ?? 'Password updated successfully',
        );
      } else {
        return ChangePasswordResponseModel(
          success: false,
          message: response.data['message'] ?? 'Failed to update password',
        );
      }
    } on DioException catch (e) {
      log('❌ DioException in changePassword: ${e.message}');
      String errorMessage = 'Something went wrong. Please try again.';

      if (e.response != null) {
        log('❌ Error response data: ${e.response?.data}');
        if (e.response?.data is Map<String, dynamic>) {
          errorMessage = e.response?.data['message'] ??
              e.response?.data['error'] ??
              errorMessage;
        }

        if (e.response?.statusCode == 401) {
          errorMessage = 'Current password is incorrect.';
        } else if (e.response?.statusCode == 400) {
          errorMessage = e.response?.data['message'] ?? 'Invalid request.';
        } else if (e.response?.statusCode == 422) {
          errorMessage = 'Validation failed. Please check your input.';
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Connection timed out. Please check your internet.';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'No internet connection.';
      }

      return ChangePasswordResponseModel(
        success: false,
        message: errorMessage,
      );
    } catch (e) {
      log('❌ Unexpected error in changePassword: $e');
      return ChangePasswordResponseModel(
        success: false,
        message: 'An unexpected error occurred.',
      );
    }
  }
}