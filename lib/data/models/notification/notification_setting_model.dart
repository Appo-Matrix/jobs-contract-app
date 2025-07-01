class NotificationSettingsModel {
  final String? userId;
  final bool emailNotifications;
  final bool pushNotifications;
  final bool smsNotifications;
  final bool promotionalNotifications;

  NotificationSettingsModel({
    this.userId,
    required this.emailNotifications,
    required this.pushNotifications,
    required this.smsNotifications,
    required this.promotionalNotifications,
  });

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) {
    return NotificationSettingsModel(
      userId: json['userId'],
      emailNotifications: json['emailNotifications'] ?? false,
      pushNotifications: json['pushNotifications'] ?? false,
      smsNotifications: json['smsNotifications'] ?? false,
      promotionalNotifications: json['promotionalNotifications'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailNotifications': emailNotifications,
      'pushNotifications': pushNotifications,
      'smsNotifications': smsNotifications,
      'promotionalNotifications': promotionalNotifications,
    };
  }
}
