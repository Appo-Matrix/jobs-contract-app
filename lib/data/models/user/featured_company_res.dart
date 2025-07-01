class FeaturedCompany {
  final String id;
  final String name;
  final String email;
  final bool isFeatured;
  final String role;

  FeaturedCompany({
    required this.id,
    required this.name,
    required this.email,
    required this.isFeatured,
    required this.role,
  });

  factory FeaturedCompany.fromJson(Map<String, dynamic> json) {
    return FeaturedCompany(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
      role: json['role'] ?? '',
    );
  }
}

class FeaturedCompanyResponse {
  final bool success;
  final String message;
  final int count;
  final int total;
  final int currentPage;
  final int totalPages;
  final List<FeaturedCompany> companies;

  FeaturedCompanyResponse({
    required this.success,
    required this.message,
    required this.count,
    required this.total,
    required this.currentPage,
    required this.totalPages,
    required this.companies,
  });

  factory FeaturedCompanyResponse.fromJson(Map<String, dynamic> json) {
    return FeaturedCompanyResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      count: json['count'] ?? 0,
      total: json['total'] ?? 0,
      currentPage: json['currentPage'] ?? 1,
      totalPages: json['totalPages'] ?? 1,
      companies: (json['data'] as List)
          .map((e) => FeaturedCompany.fromJson(e))
          .toList(),
    );
  }
}
