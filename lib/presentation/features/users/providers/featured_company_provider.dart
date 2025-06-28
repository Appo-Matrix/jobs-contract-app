import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_contracts/data/repositories/user_repository_impl.dart';
import 'package:job_contracts/domain/repository/user_repository.dart';
import '../../../../data/models/user/featured_company_res.dart';
import '../../../../utils/constants/colors.dart';


class FeaturedCompanyProvider with ChangeNotifier {
  final UserRepository _repository = UserRepositoryImpl();

  List<FeaturedCompany> _companies = [];
  bool _isLoading = false;
  String _error = '';
  int _currentPage = 1;
  int _totalPages = 1;

  List<FeaturedCompany> get companies => _companies;
  bool get isLoading => _isLoading;
  String get error => _error;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  Future<void> fetchFeaturedCompanies({int page = 1, int limit = 10}) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final res = await _repository.getFeaturedCompanies(page: page, limit: limit);
      _companies = res.companies;
      _currentPage = res.currentPage;
      _totalPages = res.totalPages;
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: _error,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: JAppColors.primary,
        textColor: Colors.white,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearCompanies() {
    _companies.clear();
    _currentPage = 1;
    _totalPages = 1;
    _error = '';
    notifyListeners();
  }
}
