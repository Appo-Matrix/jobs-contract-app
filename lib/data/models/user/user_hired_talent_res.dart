class HiredTalent {
  final String professionalId;

  HiredTalent({required this.professionalId});

  factory HiredTalent.fromJson(Map<String, dynamic> json) {
    return HiredTalent(
      professionalId: json['professionalId'],
    );
  }
}

class HiredTalentPagination {
  final int currentPage;
  final int totalPages;
  final int totalUsers;

  HiredTalentPagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalUsers,
  });

  factory HiredTalentPagination.fromJson(Map<String, dynamic> json) {
    return HiredTalentPagination(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalUsers: json['totalUsers'],
    );
  }
}

class HiredTalentListResponse {
  final bool success;
  final String message;
  final List<HiredTalent> data;
  final HiredTalentPagination pagination;

  HiredTalentListResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory HiredTalentListResponse.fromJson(Map<String, dynamic> json) {
    return HiredTalentListResponse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => HiredTalent.fromJson(e))
          .toList(),
      pagination: HiredTalentPagination.fromJson(json['pagination']),
    );
  }
}
