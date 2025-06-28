// search_repository.dart
import '../../data/models/search/remove_search_request.dart';
import '../../data/models/search/remove_search_response.dart';
import '../../data/models/search/search_request.dart';
import '../../data/models/search/search_response.dart';
import '../../data/models/search/user_search_history_response.dart';

abstract class SearchRepository {
  Future<SearchResponse> searchTalent(SearchRequest request, {int page, int limit});
  Future<List<UserSearchHistoryItem>> getUserSearchHistory(String userId);
  Future<RemoveSearchResponse> removeSearch(RemoveSearchRequest request);


}
