class PortfolioEntryModel {
  final String id;
  final String description;
  final double cost;
  final int serviceTime;
  final String beforeImageUrl;
  final String afterImageUrl;
  final String userId;

  PortfolioEntryModel({
    required this.id,
    required this.description,
    required this.cost,
    required this.serviceTime,
    required this.beforeImageUrl,
    required this.afterImageUrl,
    required this.userId,
  });

  factory PortfolioEntryModel.fromJson(Map<String, dynamic> json) {
    return PortfolioEntryModel(
      id: json['_id'] ?? '',
      description: json['description'] ?? '',
      cost: (json['cost'] ?? 0).toDouble(),
      serviceTime: json['serviceTime'] ?? 0,
      beforeImageUrl: json['before'] ?? '',
      afterImageUrl: json['after'] ?? '',
      userId: json['userId'] ?? '',
    );
  }
}
