class DeletePreferencesResponseModel {
  final bool success;
  final String message;

  DeletePreferencesResponseModel({
    required this.success,
    required this.message,
  });

  factory DeletePreferencesResponseModel.fromJson(Map<String, dynamic> json) {
    return DeletePreferencesResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
