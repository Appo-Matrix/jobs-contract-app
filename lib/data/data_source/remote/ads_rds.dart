import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/ads/ad_detail_model.dart';
import '../../models/ads/ad_model.dart';
import '../../models/ads/ad_update_request.dart';
import '../../models/ads/create_ad_model.dart';

class AdsRemoteDataSource{

  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);

  Future<String> createAd(CreateAdModel adData) async {
    final response = await apiClient.post(
      endpoint: ApiPath.createAd,
      data: adData.toJson(),
    );

    switch (response.statusCode) {
      case 201:
        return response.data['message'] ?? 'Ad created successfully';
      case 400:
      case 401:
        throw Exception(response.data['message']);
      case 500:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<AdModel>> getAllAds(Map<String, dynamic> filters) async {
    final response = await apiClient.get(
      ApiPath.getAllAds,
      queryParameters: filters,
    );

    switch (response.statusCode) {
      case 200:
        final List data = response.data;
        return data.map((e) => AdModel.fromJson(e)).toList();
      case 401:
        throw Exception("Unauthorized - missing or invalid token");
      case 500:
        throw Exception(response.data['error'] ?? 'Internal server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<void> deleteAd(String id) async {
    final response = await apiClient.delete(endpoint: ApiPath.deleteAd(id));

    switch (response.statusCode) {
      case 200:
        return;
      case 401:
        throw Exception("Unauthorized - missing or invalid token");
      case 404:
        throw Exception(response.data['error'] ?? "Ad not found");
      case 500:
        throw Exception(response.data['error'] ?? "Internal Server Error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<AdDetailModel> getAdById(String id) async {
    final response = await apiClient.get(ApiPath.getAdById(id));

    switch (response.statusCode) {
      case 200:
        return AdDetailModel.fromJson(response.data);
      case 401:
        throw Exception("Unauthorized - missing or invalid token");
      case 404:
        throw Exception(response.data['error'] ?? "Ad not found");
      case 500:
        throw Exception(response.data['error'] ?? "Internal Server Error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<AdDetailModel> updateAd(String adId, AdUpdateRequest data) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updateAd(adId),
      data: data.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return AdDetailModel.fromJson(response.data);
      case 400:
        throw Exception(response.data['error'] ?? "Invalid data");
      case 404:
        throw Exception("Ad not found");
      case 500:
        throw Exception(response.data['error'] ?? "Server error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<List<AdDetailModel>> getUserAds(String userId) async {
    final response = await apiClient.get(ApiPath.getUserAds(userId));

    switch (response.statusCode) {
      case 200:
        final List data = response.data;
        return data.map((json) => AdDetailModel.fromJson(json)).toList();
      case 404:
        throw Exception("User not found or has no ads");
      case 500:
        throw Exception("Server error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }


  Future<List<dynamic>> getNearbyAds({
    required double lat,
    required double lng,
    int maxDistance = 10000,
    int limit = 20,
    String? category,
  }) async {
    final queryParameters = {
      'lat': lat,
      'lng': lng,
      'maxDistance': maxDistance,
      'limit': limit,
      if (category != null) 'category': category,
    };

    final response = await apiClient.get(
      ApiPath.getNearbyAds,
      queryParameters: queryParameters,
    );

    switch (response.statusCode) {
      case 200:
        return response.data['data']; // Replace with proper model mapping if available
      case 400:
        throw Exception('Invalid parameters');
      case 500:
        throw Exception('Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }


  }