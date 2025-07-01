// search_repository_impl.dart
import '../../domain/repository/search_repository.dart';
import '../data_source/remote/search_rds.dart';
import '../models/search/remove_search_request.dart';
import '../models/search/remove_search_response.dart';
import '../models/search/search_request.dart';
import '../models/search/search_response.dart';
import '../models/search/user_search_history_response.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource = SearchRemoteDataSource();

  @override
  Future<SearchResponse> searchTalent(SearchRequest request, {int page = 1, int limit = 10}) async {
    try {
      return await remoteDataSource.searchTalent(request, page: page, limit: limit);
    } catch (e) {
      rethrow;
    }
  }

  // search_repository_impl.dart
  @override
  Future<List<UserSearchHistoryItem>> getUserSearchHistory(String userId) async {
    try {
      return await remoteDataSource.getUserSearchHistory(userId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RemoveSearchResponse> removeSearch(RemoveSearchRequest request) async {
    try {
      return await remoteDataSource.removeSearch(request);
    } catch (e) {
      rethrow;
    }
  }

}
