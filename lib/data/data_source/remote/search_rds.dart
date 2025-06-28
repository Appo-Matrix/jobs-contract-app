// search_remote_data_source.dart
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/search/remove_search_request.dart';
import '../../models/search/remove_search_response.dart';
import '../../models/search/search_request.dart';
import '../../models/search/search_response.dart';
import '../../models/search/user_search_history_response.dart';

class SearchRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);

  Future<SearchResponse> searchTalent(
      SearchRequest request, {
        int page = 1,
        int limit = 10,
      }) async {
    final response = await apiClient.post(
      endpoint: "${ApiPath.search}?page=$page&limit=$limit",
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return SearchResponse.fromJson(response.data);
      case 201:
        throw Exception('Search added successfully, no data returned.');
      case 400:
        throw Exception(response.data['error'] ?? 'Invalid data');
      case 500:
        throw Exception(response.data['message'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusMessage}');
    }
  }

  // search_remote_data_source.dart (add this method)
  Future<List<UserSearchHistoryItem>> getUserSearchHistory(String userId) async {
    final response = await apiClient.get("${ApiPath.getUserSearches}/$userId");

    switch (response.statusCode) {
      case 200:
        return (response.data as List)
            .map((item) => UserSearchHistoryItem.fromJson(item))
            .toList();
      case 500:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusMessage}');
    }
  }

  Future<RemoveSearchResponse> removeSearch(RemoveSearchRequest request) async {
    final response = await apiClient.delete(
      endpoint:ApiPath.removeSearch,
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return RemoveSearchResponse.fromJson(response.data);
      case 500:
        throw Exception(response.data['error'] ?? 'Internal server error');
      default:
        throw Exception('Unexpected error: ${response.statusMessage}');
    }
  }

}
