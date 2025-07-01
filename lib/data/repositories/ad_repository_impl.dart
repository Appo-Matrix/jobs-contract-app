// data/repositories/ad_repository_impl.dart

import 'package:job_contracts/data/data_source/remote/ads_rds.dart';

import '../../domain/repository/ads_repository.dart';
import '../models/ads/ad_detail_model.dart';
import '../models/ads/ad_model.dart';
import '../models/ads/ad_update_request.dart';
import '../models/ads/create_ad_model.dart';

class AdRepositoryImpl extends AdRepository {
  final AdsRemoteDataSource _remoteDataSource = AdsRemoteDataSource();

  @override
  Future<String> createAd(CreateAdModel adData) async {
    try {
      return await _remoteDataSource.createAd(adData);
    } catch (e) {
      throw Exception('Error creating ad: $e');
    }
  }

  @override
  Future<List<AdModel>> getAllAds(Map<String, dynamic> filters) async {
    try {
      return await _remoteDataSource.getAllAds(filters);
    } catch (e) {
      throw Exception('Error fetching ads: $e');
    }
  }

  @override
  Future<void> deleteAd(String id) async {
    try {
      await _remoteDataSource.deleteAd(id);
    } catch (e) {
      throw Exception('Error deleting ad: $e');
    }
  }

  @override
  Future<AdDetailModel> getAdById(String id) async {
    try {
      return await _remoteDataSource.getAdById(id);
    } catch (e) {
      throw Exception('Error fetching ad: $e');
    }
  }

  @override
  Future<AdDetailModel> updateAd(String adId, AdUpdateRequest data) async {
    try {
      return await _remoteDataSource.updateAd(adId, data);
    } catch (e) {
      throw Exception('Error updating ad: $e');
    }
  }



  @override
  Future<List<AdDetailModel>> getUserAds(String userId) async {
    try {
      return await _remoteDataSource.getUserAds(userId);
    } catch (e){
      throw Exception('Error getting user ads: $e');
    }
  }

  @override
  Future<List<dynamic>> getNearbyAds({
    required double lat,
    required double lng,
    int maxDistance = 10000,
    int limit = 20,
    String? category,
  }) {
    return _remoteDataSource.getNearbyAds(
      lat: lat,
      lng: lng,
      maxDistance: maxDistance,
      limit: limit,
      category: category,
    );
  }
}
