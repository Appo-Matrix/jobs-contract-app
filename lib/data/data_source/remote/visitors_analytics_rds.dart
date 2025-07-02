import 'package:job_contracts/core/constants/api_endpoints.dart';
import 'package:job_contracts/core/network/api_client.dart';

import '../../models/visitor_analytics/visitor_analytics_filter.dart';
import '../../models/visitor_analytics/visitor_analytics_res.dart';

class VisitorAnalyticsRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<VisitorAnalyticsResponse> getVisitorAnalytics(VisitorAnalyticsFilter filter) async {
    final response = await apiClient.get(
      ApiPath.visitorAnalytics,
      queryParameters: {'filter': filter.value},
    );

    switch (response.statusCode) {
      case 200:
        return VisitorAnalyticsResponse.fromJson(response.data);
      case 400:
        throw Exception(response.data['message'] ?? 'Invalid filter parameter');
      case 500:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }
}
