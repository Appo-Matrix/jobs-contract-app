// models/contracts/paused_contract_model.dart

class PausedContractModel {
  final String id;
  final String clientId;
  final String professionalId;
  final String status;

  PausedContractModel({
    required this.id,
    required this.clientId,
    required this.professionalId,
    required this.status,
  });

  factory PausedContractModel.fromJson(Map<String, dynamic> json) {
    return PausedContractModel(
      id: json['_id'] ?? '',
      clientId: json['clientId'] ?? '',
      professionalId: json['professionalId'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
