class Contractor {
  final String id;
  final String name;
  final String email;
  final String speciality;
  final String userType;

  Contractor({
    required this.id,
    required this.name,
    required this.email,
    required this.speciality,
    required this.userType,
  });

  factory Contractor.fromJson(Map<String, dynamic> json) {
    return Contractor(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      speciality: json['speciality'] ?? '',
      userType: json['userType'] ?? '',
    );
  }
}

class ContractorPaginationMeta {
  final int total;
  final int page;
  final int limit;
  final int pages;

  ContractorPaginationMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.pages,
  });

  factory ContractorPaginationMeta.fromJson(Map<String, dynamic> json) {
    return ContractorPaginationMeta(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      pages: json['pages'],
    );
  }
}

class ContractorBySpecialityResponse {
  final bool success;
  final List<Contractor> data;
  final ContractorPaginationMeta meta;

  ContractorBySpecialityResponse({
    required this.success,
    required this.data,
    required this.meta,
  });

  factory ContractorBySpecialityResponse.fromJson(Map<String, dynamic> json) {
    return ContractorBySpecialityResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List)
          .map((e) => Contractor.fromJson(e))
          .toList(),
      meta: ContractorPaginationMeta.fromJson(json['meta']),
    );
  }
}