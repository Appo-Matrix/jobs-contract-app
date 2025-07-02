import 'dart:io';

class PortfolioCreateRequest {
  final File beforeImage;
  final File afterImage;
  final String description;
  final double cost;
  final int serviceTime;

  PortfolioCreateRequest({
    required this.beforeImage,
    required this.afterImage,
    required this.description,
    required this.cost,
    required this.serviceTime,
  });
}
