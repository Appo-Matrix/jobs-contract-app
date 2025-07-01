class DeleteDeliveryResponse {
  final String message;

  DeleteDeliveryResponse({required this.message});

  factory DeleteDeliveryResponse.fromJson(Map<String, dynamic> json) {
    return DeleteDeliveryResponse(
      message: json['message'],
    );
  }
}
