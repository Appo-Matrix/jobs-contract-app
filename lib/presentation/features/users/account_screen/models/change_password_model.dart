class ChangePasswordModel {
  final String oldPassword;
  final String newPassword;

  ChangePasswordModel({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}

class ChangePasswordResponseModel {
  final bool success;
  final String message;

  ChangePasswordResponseModel({
    required this.success,
    required this.message,
  });

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}