import '../../data/models/deliveries/create_delivery_request.dart';
import '../../data/models/deliveries/create_delivery_response.dart';
import '../../data/models/deliveries/delete_delivery_response.dart';
import '../../data/models/deliveries/get_deliveries_response.dart';

abstract class DeliveryRepository {

  Future<CreateDeliveryResponse> createDelivery(CreateDeliveryRequest request);

  Future<GetDeliveriesResponse> getDeliveriesByJobId(String jobId);

  Future<DeleteDeliveryResponse> deleteDeliveryById(String id);


}