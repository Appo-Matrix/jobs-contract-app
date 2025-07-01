import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../data/models/user/top_performer_res.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../domain/repository/user_repository.dart';
import '../../../../utils/constants/colors.dart';


class TopPerformerProvider with ChangeNotifier {
  final UserRepository _repository = UserRepositoryImpl();

  List<TopPerformer> _performers = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;

  List<TopPerformer> get performers => _performers;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  int get currentPage => _currentPage;

  Future<void> fetchTopPerformers({
    String timePeriod = 'all',
    int page = 1,
    int limit = 10,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final data = await _repository.getTopPerformers(
        timePeriod: timePeriod,
        page: page,
        limit: limit,
      );
      _performers = data;
      _currentPage = page;
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(
        msg: _errorMessage,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: JAppColors.primary,
        textColor: Colors.white,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _performers.clear();
    _currentPage = 1;
    _errorMessage = '';
    notifyListeners();
  }
}
