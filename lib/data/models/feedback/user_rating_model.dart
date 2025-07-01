class UserRatingModel {
  final double averageRating;
  final int count;

  UserRatingModel({
    required this.averageRating,
    required this.count,
  });

  factory UserRatingModel.fromJson(Map<String, dynamic> json) {
    return UserRatingModel(
      averageRating: (json['averageRating'] as num).toDouble(),
      count: json['count'],
    );
  }
}
