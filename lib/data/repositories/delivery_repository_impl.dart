// data/repositories/delivery_repository_impl.dart

import 'package:job_contracts/data/data_source/remote/delivery_rds.dart';

import '../../domain/repository/delivery_repository.dart';
import '../models/deliveries/create_delivery_request.dart';
import '../models/deliveries/create_delivery_response.dart';
import '../models/deliveries/delete_delivery_response.dart';
import '../models/deliveries/get_deliveries_response.dart';

class DeliveryRepositoryImpl implements DeliveryRepository {
  final DeliveryRemoteDataSource remoteDataSource= DeliveryRemoteDataSource();


  @override
  Future<CreateDeliveryResponse> createDelivery(CreateDeliveryRequest request) async {
    try {
      return await remoteDataSource.createDelivery(request);
    } catch (e) {
      throw Exception('Error creating delivery: $e');
    }
  }

  @override
  Future<GetDeliveriesResponse> getDeliveriesByJobId(String jobId) async {
    try {
      return await remoteDataSource.getDeliveriesByJobId(jobId);
    } catch (e) {
      throw Exception('Error fetching deliveries by job ID: $e');
    }
  }

  @override
  Future<DeleteDeliveryResponse> deleteDeliveryById(String id) async {
    try {
      return await remoteDataSource.deleteDeliveryById(id);
    } catch (error) {
      throw Exception('Error deleting delivery: $error');
    }
  }
}
