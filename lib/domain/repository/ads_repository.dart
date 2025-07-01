// domain/repository/ad_repository.dart


import '../../data/models/ads/ad_detail_model.dart';
import '../../data/models/ads/ad_model.dart';
import '../../data/models/ads/ad_update_request.dart';
import '../../data/models/ads/create_ad_model.dart';

abstract class AdRepository {

  Future<String> createAd(CreateAdModel adData);

  Future<List<AdModel>> getAllAds(Map<String, dynamic> filters);

  Future<void> deleteAd(String id);

  Future<AdDetailModel> getAdById(String id);

  Future<AdDetailModel> updateAd(String adId, AdUpdateRequest data);

  Future<List<AdDetailModel>> getUserAds(String userId);

  Future<List<dynamic>> getNearbyAds({required double lat, required double lng, int maxDistance, int limit, String? category,});




}
