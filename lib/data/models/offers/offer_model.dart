class OfferModel {
  final String id;
  final String jobId;
  final String professionalId;
  final String clientId;
  final String status;
  final String description;
  final int budget;
  final String deliveryTime;
  final DateTime expiresIn;
  final DateTime createdAt;
  final DateTime updatedAt;

  OfferModel({
    required this.id,
    required this.jobId,
    required this.professionalId,
    required this.clientId,
    required this.status,
    required this.description,
    required this.budget,
    required this.deliveryTime,
    required this.expiresIn,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['_id'],
      jobId: json['jobId'],
      professionalId: json['professionalId'],
      clientId: json['clientId'],
      status: json['status'],
      description: json['description'],
      budget: json['budget'],
      deliveryTime: json['deliveryTime'],
      expiresIn: DateTime.parse(json['expiresIn']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobId': jobId,
      'professionalId': professionalId,
      'description': description,
      'budget': budget,
      'deliveryTime': deliveryTime,
      'expiresIn': expiresIn,
    };
  }
}


class JobInfo {
  final String id;
  final String name;

  JobInfo({required this.id, required this.name});

  factory JobInfo.fromJson(Map<String, dynamic> json) {
    return JobInfo(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class UserInfo {
  final String id;
  final String name;
  final String email;

  UserInfo({required this.id, required this.name, required this.email});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
