import 'package:job_contracts/data/data_source/remote/visitors_analytics_rds.dart';

import '../../domain/repository/visitor_analytics_repository.dart';
import '../models/visitor_analytics/visitor_analytics_filter.dart';
import '../models/visitor_analytics/visitor_analytics_res.dart';

class VisitorAnalyticsRepositoryImpl implements VisitorAnalyticsRepository {
  final VisitorAnalyticsRemoteDataSource rds = VisitorAnalyticsRemoteDataSource();


  @override
  Future<VisitorAnalyticsResponse> getVisitorAnalytics(VisitorAnalyticsFilter filter) async {
    try {
      return await rds.getVisitorAnalytics(filter);
    } catch (e) {
      rethrow;
    }
  }
}
