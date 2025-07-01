import 'package:job_contracts/core/constants/api_endpoints.dart';

import '../../../core/network/api_client.dart';
import '../../models/locations/location_model.dart';

class LocationRemoteDataSource {

  final ApiClient apiClient= ApiClient(ApiPath.baseUrl);


  Future<LocationModel> addLocation(LocationModel model) async {
    final response = await apiClient.post(
      endpoint: ApiPath.addLocation,
      data: model.toJson(),
    );

    if (response.statusCode == 201) {
      return LocationModel.fromJson(response.data['data']);
    } else if (response.statusCode == 400) {
      throw Exception(response.data['message'] ?? "Invalid input data");
    } else {
      throw Exception(response.data['error'] ?? "Server error");
    }
  }

  Future<void> deleteLocation(String userId) async {
    final response = await apiClient.delete(
      endpoint: ApiPath.deleteLocation(userId),
    );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 404) {
      throw Exception("Location not found");
    } else {
      throw Exception(response.data['error'] ?? "Server error");
    }
  }

  Future<LocationModel> getLocationByUserId(String userId) async {
    final response = await apiClient.get(
       ApiPath.getLocationByUserId(userId),
    );

    if (response.statusCode == 200) {
      return LocationModel.fromJson(response.data['data']);
    } else if (response.statusCode == 404) {
      throw Exception("Location not found for this user");
    } else {
      throw Exception(response.data['error'] ?? "Server error");
    }
  }

  Future<LocationModel> updateLocation(String userId, LocationModel model) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updateLocation(userId),
      data: model.toJson(),
    );

    if (response.statusCode == 200) {
      return LocationModel.fromJson(response.data['data']);
    } else if (response.statusCode == 400) {
      throw Exception("Invalid input data");
    } else if (response.statusCode == 404) {
      throw Exception("Location not found");
    } else {
      throw Exception(response.data['error'] ?? "Server error");
    }
  }

  Future<List<LocationModel>> fetchAllLocations() async {
    final response = await apiClient.get(ApiPath.getAllLocations);

    if (response.statusCode == 200) {
      final List data = response.data['data'];
      return data.map((json) => LocationModel.fromJson(json)).toList();
    } else {
      throw Exception(response.data['error'] ?? 'Failed to fetch locations');
    }
  }


  Future<LocationModel> getCurrentUserLocation() async {
    final response = await apiClient.get(ApiPath.getUserLocation);

    if (response.statusCode == 200) {
      return LocationModel.fromJson(response.data['data']);
    } else if (response.statusCode == 404) {
      throw Exception("Location not found for this user");
    } else {
      throw Exception(response.data['error'] ?? 'Failed to fetch location');
    }
  }
}
