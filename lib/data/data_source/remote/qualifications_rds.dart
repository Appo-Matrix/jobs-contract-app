
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/education/education_model.dart';
import '../../models/education/qualification_model.dart';
import '../../models/education/qualification_request.dart';
import '../../models/education/qualification_response.dart';
import '../../models/education/user_education_model.dart';

class QualificationRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<QualificationResponse> addQualification(QualificationRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.addQualification,
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 201:
        return QualificationResponse.fromJson(response.data);
      case 400:
        throw Exception((response.data['message'] as List).join(", "));
      case 401:
        throw Exception("Unauthorized request");
      case 500:
        throw Exception(response.data['error'] ?? "Server Error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }


  Future<void> deleteQualification(String eduId) async {
    final response = await apiClient.delete(
      endpoint: ApiPath.deleteQualification(eduId),
    );

    switch (response.statusCode) {
      case 200:
        return;
      case 401:
        throw Exception("Unauthorized request");
      case 404:
        throw Exception("Education entry not found");
      case 500:
        throw Exception(response.data['error'] ?? "Server Error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<EducationModel> getQualificationById(String eduId) async {
    final response = await apiClient.get(ApiPath.getQualificationById(eduId));

    switch (response.statusCode) {
      case 200:
        return EducationModel.fromJson(response.data);
      case 401:
        throw Exception("Unauthorized request");
      case 404:
        throw Exception("Education entry not found");
      case 500:
        throw Exception(response.data['error'] ?? "Server Error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }


  Future<EducationModel> updateQualification(String eduId, EducationModel data) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updateQualification(eduId),
      data: data.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return EducationModel.fromJson(response.data['updatedEducation']);
      case 400:
        throw Exception(response.data['message']?.join(", ") ?? "Validation Error");
      case 404:
        throw Exception("Education entry not found");
      case 500:
        throw Exception(response.data['error'] ?? "Internal Server Error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<List<QualificationModel>> getQualificationsByUserId(String userId) async {
    final response = await apiClient.get(ApiPath.getQualificationsByUserId(userId));

    switch (response.statusCode) {
      case 200:
        final data = response.data;
        if (data is List) {
          return data.map((e) => QualificationModel.fromJson(e)).toList();
        } else {
          throw Exception("Invalid response format");
        }

      case 500:
        throw Exception(response.data['error'] ?? "Internal Server Error");

      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }


  Future<List<UserEducationModel>> getMyQualifications() async {
    final response = await apiClient.get(ApiPath.getMyQualifications);

    switch (response.statusCode) {
      case 200:
        final List data = response.data;
        return data.map((json) => UserEducationModel.fromJson(json)).toList();
      case 401:
        throw Exception("Unauthorized request");
      case 404:
        throw Exception("No education entries found");
      case 500:
        throw Exception(response.data['error'] ?? "Internal Server Error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }
}
