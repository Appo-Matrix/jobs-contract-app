// models/contracts/user_contract_model.dart
class UserContractModel {
  final String id;
  final String clientId;
  final String professionalId;

  UserContractModel({
    required this.id,
    required this.clientId,
    required this.professionalId,
  });

  factory UserContractModel.fromJson(Map<String, dynamic> json) {
    return UserContractModel(
      id: json['_id'] ?? '',
      clientId: json['clientId'] ?? '',
      professionalId: json['professionalId'] ?? '',
    );
  }
}
