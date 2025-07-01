// providers/delivery_provider.dart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_contracts/data/repositories/delivery_repository_impl.dart';

import '../../../../data/models/deliveries/create_delivery_request.dart';
import '../../../../data/models/deliveries/create_delivery_response.dart';
import '../../../../data/models/deliveries/get_deliveries_response.dart';
import '../../../../domain/repository/delivery_repository.dart';


class DeliveryProvider with ChangeNotifier {
  final DeliveryRepository repository =DeliveryRepositoryImpl();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  CreateDeliveryResponse? _deliveryResponse;
  CreateDeliveryResponse? get deliveryResponse => _deliveryResponse;

  GetDeliveriesResponse? _deliveriesResponse;
  GetDeliveriesResponse? get deliveriesResponse => _deliveriesResponse;

  Future<void> createDelivery(CreateDeliveryRequest request) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _deliveryResponse = await repository.createDelivery(request);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchDeliveriesByJob(String jobId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _deliveriesResponse = await repository.getDeliveriesByJobId(jobId);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteDelivery(String deliveryId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await repository.deleteDeliveryById(deliveryId);
      Fluttertoast.showToast(msg: response.message);
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
