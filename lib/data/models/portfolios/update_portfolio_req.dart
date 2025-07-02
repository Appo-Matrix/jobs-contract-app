class UpdatePortfolioRequestModel {
  final String before;
  final String after;
  final String description;
  final double cost;
  final int serviceTime;

  UpdatePortfolioRequestModel({
    required this.before,
    required this.after,
    required this.description,
    required this.cost,
    required this.serviceTime,
  });

  Map<String, dynamic> toJson() => {
    'before': before,
    'after': after,
    'description': description,
    'cost': cost,
    'serviceTime': serviceTime,
  };
}
