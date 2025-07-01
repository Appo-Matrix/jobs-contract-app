// data/models/deliveries/create_delivery_response.dart

class CreateDeliveryResponse {
  final String message;

  CreateDeliveryResponse({required this.message});

  factory CreateDeliveryResponse.fromJson(dynamic json) {
    return CreateDeliveryResponse(message: json.toString());
  }
}
