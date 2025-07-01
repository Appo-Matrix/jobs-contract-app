class Talent {
  final String id;
  final String name;
  final String email;

  Talent({required this.id, required this.name, required this.email});

  factory Talent.fromJson(Map<String, dynamic> json) {
    return Talent(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalUsers;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalUsers,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalUsers: json['totalUsers'],
    );
  }
}

class TalentListResponse {
  final bool success;
  final String message;
  final List<Talent> data;
  final Pagination pagination;

  TalentListResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory TalentListResponse.fromJson(Map<String, dynamic> json) {
    return TalentListResponse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List).map((e) => Talent.fromJson(e)).toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}
