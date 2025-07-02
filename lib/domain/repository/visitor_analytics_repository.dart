import '../../data/models/visitor_analytics/visitor_analytics_filter.dart';
import '../../data/models/visitor_analytics/visitor_analytics_res.dart';

abstract class VisitorAnalyticsRepository {

  Future<VisitorAnalyticsResponse> getVisitorAnalytics(VisitorAnalyticsFilter filter);
}
