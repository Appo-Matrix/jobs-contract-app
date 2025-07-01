// data/remote_data_sources/delivery_remote_data_source.dart

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/deliveries/create_delivery_request.dart';
import '../../models/deliveries/create_delivery_response.dart';
import '../../models/deliveries/delete_delivery_response.dart';
import '../../models/deliveries/get_deliveries_response.dart';

class DeliveryRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<CreateDeliveryResponse> createDelivery(CreateDeliveryRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.createDelivery,
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 201:
        return CreateDeliveryResponse.fromJson(response.data);
      case 400:
        throw Exception(response.data['error'] ?? 'Bad request');
      default:
        throw Exception('Server error: ${response.statusCode}');
    }
  }

  Future<GetDeliveriesResponse> getDeliveriesByJobId(String jobId) async {
    final response = await apiClient.get(
      ApiPath.getDeliveriesByJob(jobId),
    );

    switch (response.statusCode) {
      case 200:
        return GetDeliveriesResponse.fromJson(response.data);
      case 404:
        throw Exception(response.data['error'] ?? 'No deliveries found');
      default:
        throw Exception('Server error: ${response.statusCode}');
    }
  }

  Future<DeleteDeliveryResponse> deleteDeliveryById(String id) async {
    final response = await apiClient.delete(
      endpoint: ApiPath.deleteDeliveryById(id),
    );

    switch (response.statusCode) {
      case 200:
        return DeleteDeliveryResponse.fromJson(response.data);
      case 404:
        throw Exception('Delivery not found');
      case 500:
        throw Exception(response.data['error'] ?? 'Failed to delete delivery');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }
}
