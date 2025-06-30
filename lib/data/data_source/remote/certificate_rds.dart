// certificate_remote_data_source.dart
import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/certificate/add_certificate_req.dart';
import '../../models/certificate/add_certificate_res.dart';
import '../../models/certificate/delete_certificate_res.dart';
import '../../models/certificate/get_user_certificates_res.dart';
import '../../models/certificate/update_certificate_req.dart';
import '../../models/certificate/update_certificate_res.dart';


class CertificateRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<AddCertificateResponse> addCertificate(AddCertificateRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.addCertificate,
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 201:
        return AddCertificateResponse.fromJson(response.data);
      case 400:
        throw Exception(response.data['error'] ?? 'Validation failed');
      case 401:
        throw Exception(response.data['message'] ?? 'Unauthorized');
      default:
        throw Exception('Unexpected error: ${response.statusMessage}');
    }
  }

  Future<List<Certificate>> getUserCertificates(String userId) async {
    final response = await apiClient.get(ApiPath.getUserCertificates(userId));

    switch (response.statusCode) {
      case 200:
        final List data = response.data;
        return data.map((json) => Certificate.fromJson(json)).toList();
      case 401:
        throw Exception(response.data['message'] ?? 'Unauthorized');
      default:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
    }
  }

  Future<DeleteCertificateResponse> deleteCertificate(String certificateId) async {
    final response = await apiClient.delete(endpoint: ApiPath.deleteCertificate(certificateId));

    switch (response.statusCode) {
      case 200:
        return DeleteCertificateResponse.fromJson(response.data);
      case 401:
        throw Exception(response.data['message'] ?? 'Unauthorized');
      case 404:
        throw Exception(response.data['message'] ?? 'Certificate not found');
      default:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
    }
  }

  Future<UpdateCertificateResponse> updateCertificate(String id, UpdateCertificateRequest request) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updateCertificate(id),
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return UpdateCertificateResponse.fromJson(response.data);
      case 400:
        throw Exception(response.data['error'] ?? 'Validation failed');
      case 401:
        throw Exception(response.data['message'] ?? 'Unauthorized');
      default:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
    }
  }

}
