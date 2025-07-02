class WebhookResponseModel {
  final bool received;

  WebhookResponseModel({required this.received});

  factory WebhookResponseModel.fromJson(Map<String, dynamic> json) {
    return WebhookResponseModel(
      received: json['received'] ?? false,
    );
  }
}
