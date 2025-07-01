// lib/data/data_source/remote/language_rds.dart
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/language/language_model.dart';

class LanguageRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);

  Future<LanguageModel> addLanguage(LanguageModel model) async {
    final response = await apiClient.post(
      endpoint: ApiPath.addLanguage,
      data: model.toJson(),
    );

    if (response.statusCode == 200) {
      return LanguageModel.fromJson(response.data['data']);
    } else if (response.statusCode == 400) {
      throw Exception(response.data['message'] ?? "Validation failed");
    } else {
      throw Exception(response.data['error'] ?? "Server error");
    }
  }

  Future<LanguageModel> getLanguageById(String id) async {
    final response = await apiClient.get(
       ApiPath.getLanguage(id),
    );

    if (response.statusCode == 200) {
      return LanguageModel.fromJson(response.data['data']);
    } else if (response.statusCode == 404) {
      throw Exception(response.data['message'] ?? "Language not found");
    } else {
      throw Exception(response.data['error'] ?? "Server error");
    }
  }

  Future<void> deleteLanguage(String id) async {
    final response = await apiClient.delete(endpoint: ApiPath.deleteLanguage(id));

    if (response.statusCode == 200) {
      // success
      return;
    } else if (response.statusCode == 404) {
      throw Exception(response.data['message'] ?? 'Language not found');
    } else {
      throw Exception(response.data['error'] ?? 'Failed to delete language');
    }
  }

  Future<LanguageModel> updateLanguage(String id, LanguageModel model) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updateLanguage(id),
      data: model.toJson(),
    );

    if (response.statusCode == 200) {
      return LanguageModel.fromJson(response.data['language']);
    } else if (response.statusCode == 400) {
      throw Exception(response.data['message'] ?? 'Validation error');
    } else if (response.statusCode == 404) {
      throw Exception(response.data['message'] ?? 'Language not found');
    } else {
      throw Exception(response.data['error'] ?? 'Server error');
    }
  }

  Future<List<LanguageModel>> getMyLanguages() async {
    final response = await apiClient.get(ApiPath.getMyLanguages);

    if (response.statusCode == 200) {
      final List data = response.data['data'];
      return data.map((e) => LanguageModel.fromJson(e)).toList();
    } else {
      throw Exception(response.data['error'] ?? 'Failed to retrieve languages');
    }
  }


}
