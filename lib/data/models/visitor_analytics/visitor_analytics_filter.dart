enum VisitorAnalyticsFilter {
  last7Days,
  last30Days,
  last12Months,
}

extension VisitorAnalyticsFilterExt on VisitorAnalyticsFilter {
  String get value {
    switch (this) {
      case VisitorAnalyticsFilter.last7Days:
        return 'last_7_days';
      case VisitorAnalyticsFilter.last30Days:
        return 'last_30_days';
      case VisitorAnalyticsFilter.last12Months:
        return 'last_12_months';
    }
  }
}
