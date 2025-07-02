import 'package:flutter/material.dart';
import 'package:job_contracts/data/repositories/visitor_analytics_repository_impl.dart';

import '../../../../data/models/visitor_analytics/visitor_analytics_filter.dart';
import '../../../../data/models/visitor_analytics/visitor_analytics_res.dart';
import '../../../../domain/repository/visitor_analytics_repository.dart';

class VisitorAnalyticsProvider with ChangeNotifier {
  final VisitorAnalyticsRepository repository = VisitorAnalyticsRepositoryImpl();


  bool _isLoading = false;
  String? _error;
  VisitorAnalyticsResponse? _response;

  bool get isLoading => _isLoading;
  String? get error => _error;
  VisitorAnalyticsResponse? get response => _response;

  Future<void> fetchAnalytics(VisitorAnalyticsFilter filter) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _response = await repository.getVisitorAnalytics(filter);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
