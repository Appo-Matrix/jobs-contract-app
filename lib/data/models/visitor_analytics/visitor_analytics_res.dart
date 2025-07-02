class VisitorAnalyticsResponse {
  final Map<String, VisitorAnalyticsData> analytics;

  VisitorAnalyticsResponse({required this.analytics});

  factory VisitorAnalyticsResponse.fromJson(Map<String, dynamic> json) {
    final map = <String, VisitorAnalyticsData>{};
    json.forEach((key, value) {
      map[key] = VisitorAnalyticsData.fromJson(value);
    });
    return VisitorAnalyticsResponse(analytics: map);
  }
}

class VisitorAnalyticsData {
  final int uniqueVisitors;
  final int loyalCustomers;
  final int newCustomers;

  VisitorAnalyticsData({
    required this.uniqueVisitors,
    required this.loyalCustomers,
    required this.newCustomers,
  });

  factory VisitorAnalyticsData.fromJson(Map<String, dynamic> json) {
    return VisitorAnalyticsData(
      uniqueVisitors: json['uniqueVisitors'],
      loyalCustomers: json['loyalCustomers'],
      newCustomers: json['newCustomers'],
    );
  }
}
