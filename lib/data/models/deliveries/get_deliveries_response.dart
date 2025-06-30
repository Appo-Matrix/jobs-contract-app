// data/models/deliveries/get_deliveries_response.dart

class GetDeliveriesResponse {
  final List<String> deliveries;

  GetDeliveriesResponse({required this.deliveries});

  factory GetDeliveriesResponse.fromJson(List<dynamic> json) {
    return GetDeliveriesResponse(
      deliveries: json.map((e) => e.toString()).toList(),
    );
  }
}
