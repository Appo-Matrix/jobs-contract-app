// data/repositories/ad_repository_impl.dart

import 'package:flutter/foundation.dart';

import '../../domain/repository/ads_repository.dart';
import '../data_source/remote/ads_rds.dart';
import '../models/ads/ad_detail_model.dart';
import '../models/ads/ad_model.dart';
import '../models/ads/ad_update_request.dart';
import '../models/ads/create_ad_model.dart';

class AdRepositoryImpl extends AdRepository {
  final AdsRemoteDataSource _remoteDataSource = AdsRemoteDataSource();

  // ================= CREATE AD =================
  @override
  Future<String> createAd(CreateAdModel adData) async {
    try {
      debugPrint("📤 Creating Ad: ${adData.toJson()}");

      final response = await _remoteDataSource.createAd(adData);

      debugPrint("✅ Ad Created Successfully: $response");

      return response;
    } catch (e, stackTrace) {
      debugPrint("❌ Error Creating Ad: $e");
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  // ================= GET ALL ADS =================
  @override
  Future<List<AdModel>> getAllAds(Map<String, dynamic> filters) async {
    try {
      debugPrint("📥 Fetching Ads with filters: $filters");

      final ads = await _remoteDataSource.getAllAds(filters);

      debugPrint("✅ Fetched ${ads.length} Ads");

      return ads;
    } catch (e, stackTrace) {
      debugPrint("❌ Error Fetching Ads: $e");
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  // ================= DELETE AD =================
  @override
  Future<void> deleteAd(String id) async {
    try {
      debugPrint("🗑 Deleting Ad ID: $id");

      await _remoteDataSource.deleteAd(id);

      debugPrint("✅ Ad Deleted Successfully");
    } catch (e, stackTrace) {
      debugPrint("❌ Error Deleting Ad: $e");
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  // ================= GET AD BY ID =================
  @override
  Future<AdDetailModel> getAdById(String id) async {
    try {
      debugPrint("📥 Fetching Ad by ID: $id");

      final ad = await _remoteDataSource.getAdById(id);

      debugPrint("✅ Ad Fetched Successfully");

      return ad;
    } catch (e, stackTrace) {
      debugPrint("❌ Error Fetching Ad: $e");
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  // ================= UPDATE AD =================
  @override
  Future<AdDetailModel> updateAd(String adId, AdUpdateRequest data) async {
    try {
      debugPrint("✏️ Updating Ad ID: $adId");
      debugPrint("📤 Update Data: ${data.toJson()}");

      final updatedAd = await _remoteDataSource.updateAd(adId, data);

      debugPrint("✅ Ad Updated Successfully");

      return updatedAd;
    } catch (e, stackTrace) {
      debugPrint("❌ Error Updating Ad: $e");
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  // ================= GET USER ADS =================
  @override
  Future<List<AdDetailModel>> getUserAds(String userId) async {
    try {
      debugPrint("📥 Fetching Ads for User ID: $userId");

      final ads = await _remoteDataSource.getUserAds(userId);

      debugPrint("✅ User Ads Count: ${ads.length}");

      return ads;
    } catch (e, stackTrace) {
      debugPrint("❌ Error Getting User Ads: $e");
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  // ================= GET NEARBY ADS =================
  @override
  Future<List<dynamic>> getNearbyAds({
    required double lat,
    required double lng,
    int maxDistance = 10000,
    int limit = 20,
    String? category,
  }) async {
    try {
      debugPrint("📍 Fetching Nearby Ads");
      debugPrint("Latitude: $lat, Longitude: $lng");
      debugPrint("Max Distance: $maxDistance, Limit: $limit, Category: $category");

      final ads = await _remoteDataSource.getNearbyAds(
        lat: lat,
        lng: lng,
        maxDistance: maxDistance,
        limit: limit,
        category: category,
      );

      debugPrint("✅ Nearby Ads Fetched: ${ads.length}");

      return ads;
    } catch (e, stackTrace) {
      debugPrint("❌ Error Fetching Nearby Ads: $e");
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }
}