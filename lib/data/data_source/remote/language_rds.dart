import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/language/language_model.dart';

class LanguageRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);

  // ── Add language ──────────────────────────────────────────────────────────
  Future<LanguageModel> addLanguage(LanguageModel model) async {
    final response = await apiClient.post(
      endpoint: ApiPath.addLanguage,
      data: model.toJson(),
    );

    switch (response.statusCode) {
      case 200:
      case 201:
        return LanguageModel.fromJson(response.data['data']);
      case 400:
        throw Exception(response.data['message'] ?? 'Validation failed');
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  // ── Get language by ID ────────────────────────────────────────────────────
  Future<LanguageModel> getLanguageById(String id) async {
    final response = await apiClient.get(ApiPath.getLanguage(id));

    switch (response.statusCode) {
      case 200:
        return LanguageModel.fromJson(response.data['data']);
      case 404:
        throw Exception(response.data['message'] ?? 'Language not found');
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  // ── Delete language ───────────────────────────────────────────────────────
  Future<void> deleteLanguage(String id) async {
    final response = await apiClient.delete(
      endpoint: ApiPath.deleteLanguage(id),
    );

    switch (response.statusCode) {
      case 200:
        return;
      case 404:
        throw Exception(response.data['message'] ?? 'Language not found');
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  // ── Update language ───────────────────────────────────────────────────────
  Future<LanguageModel> updateLanguage(String id, LanguageModel model) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updateLanguage(id),
      data: model.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return LanguageModel.fromJson(response.data['data']);
      case 400:
        throw Exception(response.data['message'] ?? 'Validation error');
      case 404:
        throw Exception(response.data['message'] ?? 'Language not found');
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  // ── Get my languages ──────────────────────────────────────────────────────
  Future<List<LanguageModel>> getMyLanguages() async {
    final response = await apiClient.get(ApiPath.getMyLanguages);

    switch (response.statusCode) {
      case 200:
        final List data = response.data['data'] as List;
        return data
            .map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
            .toList();
      case 404:
        return [];
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }
}