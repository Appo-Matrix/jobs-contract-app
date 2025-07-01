

import '../../data/models/locations/location_model.dart';

abstract class LocationRepository {

  Future<LocationModel> addLocation(LocationModel model);

  Future<void> deleteLocation(String userId);

  Future<LocationModel> getLocationByUserId(String userId);

  Future<LocationModel> updateLocation(String userId, LocationModel model);

  Future<List<LocationModel>> fetchAllLocations();

  Future<LocationModel> getCurrentUserLocation();


}
