// providers/ad_provider.dart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/models/ads/ad_detail_model.dart';
import '../../../../data/models/ads/ad_model.dart';
import '../../../../data/models/ads/ad_update_request.dart';
import '../../../../data/models/ads/create_ad_model.dart';
import '../../../../data/repositories/ad_repository_impl.dart';
import '../../../../domain/repository/ads_repository.dart';


class AdProvider with ChangeNotifier {
  final AdRepository _repository = AdRepositoryImpl();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<AdModel> _ads = [];
  List<AdModel> get ads => _ads;

  AdDetailModel? _ad;
  AdDetailModel? get ad => _ad;

  AdDetailModel? _updatedAd;
  AdDetailModel? get updatedAd => _updatedAd;

  List<AdDetailModel> _userAds = [];
  List<AdDetailModel> get userAds => _userAds;

  List<dynamic> _nearbyAds = [];
  List<dynamic> get nearbyAds => _nearbyAds;







  Future<void> createAd(CreateAdModel adData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final message = await _repository.createAd(adData);
      Fluttertoast.showToast(msg: message);
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchAds({
    int page = 1,
    int limit = 10,
    String? userId,
    String? status,
    num? minPrice,
    num? maxPrice,
    double? lat,
    double? lng,
    int radius = 10000,
  }) async {
    _isLoading = true;
    notifyListeners();

    final filters = <String, dynamic>{
      "page": page,
      "limit": limit,
      if (userId != null) "userId": userId,
      if (status != null) "status": status,
      if (minPrice != null) "minPrice": minPrice,
      if (maxPrice != null) "maxPrice": maxPrice,
      if (lat != null) "lat": lat,
      if (lng != null) "lng": lng,
      "radius": radius,
    };

    try {
      _ads = await _repository.getAllAds(filters);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAd(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.deleteAd(id);
      Fluttertoast.showToast(msg: "Ad deleted successfully");
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchAdById(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _ad = await _repository.getAdById(id);
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAd(String adId, AdUpdateRequest request) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _updatedAd = await _repository.updateAd(adId, request);
      Fluttertoast.showToast(msg: 'Ad updated successfully');
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserAds(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _userAds = await _repository.getUserAds(userId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchNearbyAds({
    required double lat,
    required double lng,
    int maxDistance = 10000,
    int limit = 20,
    String? category,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _nearbyAds = await _repository.getNearbyAds(
        lat: lat,
        lng: lng,
        maxDistance: maxDistance,
        limit: limit,
        category: category,
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
