

import 'package:job_contracts/data/data_source/remote/language_rds.dart';

import '../../domain/repository/location_repository.dart';
import '../data_source/remote/location_rds.dart';
import '../models/locations/location_model.dart';

class LocationRepositoryImpl implements LocationRepository {

  final LocationRemoteDataSource remoteDataSource = LocationRemoteDataSource();

  @override
  Future<LocationModel> addLocation(LocationModel model) async {
    try {
      return await remoteDataSource.addLocation(model);
    } catch (e) {
      throw Exception('Error adding location: $e');
    }
  }

  @override
  Future<void> deleteLocation(String userId) async {
    try {
      return await remoteDataSource.deleteLocation(userId);
    } catch (e) {
      throw Exception('Error deleting location: $e');
    }
  }

  @override
  Future<LocationModel> getLocationByUserId(String userId) async {
    try {
      return await remoteDataSource.getLocationByUserId(userId);
    } catch (e) {
      throw Exception('Error getting location: $e');
    }
  }


  @override
  Future<LocationModel> updateLocation(String userId, LocationModel model) async {
    try {
      return await remoteDataSource.updateLocation(userId, model);
    } catch (e) {
      throw Exception('Error updating location: $e');
    }
  }

  @override
  Future<List<LocationModel>> fetchAllLocations() async {
    try {
      return await remoteDataSource.fetchAllLocations();
    } catch (e) {
      throw Exception('Error fetching all locations: $e');
    }
  }

  @override
  Future<LocationModel> getCurrentUserLocation() async {
    try {
      return await remoteDataSource.getCurrentUserLocation();
    } catch (e) {
      throw Exception('Error fetching current user location: $e');
    }
  }

}
