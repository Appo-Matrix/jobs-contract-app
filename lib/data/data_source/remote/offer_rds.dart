import 'package:job_contracts/core/constants/api_endpoints.dart';
import 'package:job_contracts/core/network/api_client.dart';

import '../../models/offers/offer_model.dart';

class OfferRemoteDataSource {
  final ApiClient apiClient= ApiClient(ApiPath.baseUrl);


  Future<OfferModel> acceptOffer(String offerId) async {
    final response = await apiClient.put(
      endpoint: ApiPath.acceptOffer(offerId),
    );

    if (response.statusCode == 200) {
      return OfferModel.fromJson(response.data['offer']);
    } else if (response.statusCode == 403) {
      throw Exception(response.data['message'] ?? 'Not authorized to accept this offer');
    } else if (response.statusCode == 404) {
      throw Exception(response.data['message'] ?? 'Offer not found');
    } else {
      throw Exception(response.data['error'] ?? 'Server error');
    }
  }

  Future<OfferModel> sendOffer(OfferModel model) async {
    final response = await apiClient.post(
      endpoint: ApiPath.sendOffer,
      data: model.toJson(),
    );

    if (response.statusCode == 201) {
      return OfferModel.fromJson(response.data);
    } else if (response.statusCode == 400) {
      throw Exception("Bad request: Missing or invalid data.");
    } else if (response.statusCode == 404) {
      throw Exception("Job or professional not found.");
    } else {
      throw Exception(response.data['error'] ?? "Server error");
    }
  }

  Future<void> deleteOffer(String offerId) async {
    final response = await apiClient.delete(
      endpoint: ApiPath.deleteOffer(offerId),
    );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 403) {
      throw Exception("Not authorized to delete this offer.");
    } else if (response.statusCode == 404) {
      throw Exception("Offer not found.");
    } else {
      throw Exception(response.data['error'] ?? "Server error");
    }
  }

  Future<OfferModel> getOfferById(String offerId) async {
    final response = await apiClient.get(
      ApiPath.getOfferById(offerId),
    );

    if (response.statusCode == 200) {
      return OfferModel.fromJson(response.data);
    } else if (response.statusCode == 404) {
      throw Exception("Offer not found");
    } else {
      throw Exception(response.data['error'] ?? "Server error");
    }
  }

  Future<OfferModel> updateOffer(String offerId, Map<String, dynamic> updateData) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updateOffer(offerId),
      data: updateData,
    );

    if (response.statusCode == 200) {
      return OfferModel.fromJson(response.data);
    } else if (response.statusCode == 403) {
      throw Exception("Not authorized to update this offer");
    } else if (response.statusCode == 404) {
      throw Exception("Offer not found");
    } else {
      throw Exception(response.data['error'] ?? "Server error");
    }
  }

  Future<List<OfferModel>> fetchOffers({
    String? jobId,
    String? clientId,
    String? professionalId,
    String? status,
  }) async {
    final queryParams = {
      if (jobId != null) 'jobId': jobId,
      if (clientId != null) 'clientId': clientId,
      if (professionalId != null) 'professionalId': professionalId,
      if (status != null) 'status': status,
    };

    final response = await apiClient.get(
      ApiPath.fetchOffers,
      queryParameters: queryParams,
    );

    if (response.statusCode == 200) {
      return List<OfferModel>.from(response.data.map((e) => OfferModel.fromJson(e)));
    } else {
      throw Exception(response.data['error'] ?? 'Failed to fetch offers');
    }
  }

  Future<OfferModel> rejectOffer(String id) async {
    final response = await apiClient.put(endpoint: ApiPath.rejectOffer(id));

    if (response.statusCode == 200) {
      return OfferModel.fromJson(response.data['offer']);
    } else {
      throw Exception(response.data['message'] ?? 'Failed to reject offer');
    }
  }
}
