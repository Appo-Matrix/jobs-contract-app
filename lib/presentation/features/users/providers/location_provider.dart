// provider/location_provider.dart
import 'package:flutter/material.dart';
import 'package:job_contracts/data/repositories/location_repository_impl.dart';

import '../../../../data/models/locations/location_model.dart';
import '../../../../domain/repository/location_repository.dart';

class LocationProvider with ChangeNotifier {

  final LocationRepository repository = LocationRepositoryImpl();


  bool isLoading = false;
  String? errorMessage;

  LocationModel? _location;
  LocationModel? get location => _location;


  List<LocationModel> _locations = [];
  List<LocationModel> get locations => _locations;


  LocationModel? _currentUserLocation;
  LocationModel? get currentUserLocation => _currentUserLocation;

  Future<void> addLocation(LocationModel model) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final newLocation = await repository.addLocation(model);
      _location = newLocation;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteLocation(String userId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await repository.deleteLocation(userId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLocationByUserId(String userId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await repository.getLocationByUserId(userId);
      _location = result;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserLocation(String userId, LocationModel model) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await repository.updateLocation(userId, model);
      _location = result;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllLocations() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      _locations = await repository.fetchAllLocations();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCurrentUserLocation() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      _currentUserLocation = await repository.getCurrentUserLocation();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


}
