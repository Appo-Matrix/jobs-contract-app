// search_provider.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../../data/models/search/remove_search_request.dart';
import '../../../../../data/models/search/search_request.dart';
import '../../../../../data/models/search/search_response.dart';
import '../../../../../data/models/search/user_search_history_response.dart';
import '../../../../../data/repositories/search_repository_impl.dart';
import '../../../../../domain/repository/search_repository.dart';
import '../../../../../utils/constants/colors.dart';


class SearchProvider with ChangeNotifier {
  final SearchRepository _repository = SearchRepositoryImpl();

  bool _isLoading = false;
  String _errorMessage = '';
  List<SearchResultItem> _results = [];

  List<UserSearchHistoryItem> _searchHistory = [];
  List<UserSearchHistoryItem> get searchHistory => _searchHistory;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<SearchResultItem> get results => _results;

  Future<void> searchTalent(
      BuildContext context,
      SearchRequest request, {
        int page = 1,
        int limit = 10,
      }) async {
    context.loaderOverlay.show();
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _repository.searchTalent(request, page: page, limit: limit);
      _results = response.data;
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(
        msg: "Error: $_errorMessage",
        gravity: ToastGravity.CENTER,
        backgroundColor: JAppColors.error900,
        textColor: Colors.white,
      );
    } finally {
      context.loaderOverlay.hide();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserSearchHistory(BuildContext context, String userId) async {
    context.loaderOverlay.show();
    _isLoading = true;
    notifyListeners();

    try {
      final history = await _repository.getUserSearchHistory(userId);
      _searchHistory = history;
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(
        msg: "Error: $_errorMessage",
        gravity: ToastGravity.CENTER,
        backgroundColor: JAppColors.error900,
        textColor: Colors.white,
      );
    } finally {
      context.loaderOverlay.hide();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeSearch(BuildContext context, String userId, String searchQuery) async {
    context.loaderOverlay.show();
    _isLoading = true;
    notifyListeners();

    try {
      final request = RemoveSearchRequest(userId: userId, search: searchQuery);
      final response = await _repository.removeSearch(request);

      Fluttertoast.showToast(
        msg: response.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(
        msg: _errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: JAppColors.error900,
        textColor: Colors.white,
      );
    } finally {
      context.loaderOverlay.hide();
      _isLoading = false;
      notifyListeners();
    }
  }
}
