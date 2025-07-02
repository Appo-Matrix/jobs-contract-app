import 'package:job_contracts/data/data_source/remote/offer_rds.dart';

import '../../domain/repository/offer_repository.dart';
import '../models/offers/offer_model.dart';

class OfferRepositoryImpl implements OfferRepository {
  final OfferRemoteDataSource remoteDataSource = OfferRemoteDataSource();


  @override
  Future<OfferModel> acceptOffer(String offerId) async {
    try {
      return await remoteDataSource.acceptOffer(offerId);
    } catch (e) {
      throw Exception('Error accepting offer: $e');
    }
  }


  @override
  Future<OfferModel> sendOffer(OfferModel offer) async {
    try {
      return await remoteDataSource.sendOffer(offer);
    } catch (e) {
      throw Exception('Error sending offer: $e');
    }
  }

  @override
  Future<void> deleteOffer(String offerId) async {
    try {
      await remoteDataSource.deleteOffer(offerId);
    } catch (e) {
      throw Exception('Error deleting offer: $e');
    }
  }

  @override
  Future<OfferModel> getOfferById(String offerId) async {
    try {
      return await remoteDataSource.getOfferById(offerId);
    } catch (e) {
      throw Exception('Error fetching offer: $e');
    }
  }

  @override
  Future<OfferModel> updateOffer(String offerId, Map<String, dynamic> updateData) async {
    try {
      return await remoteDataSource.updateOffer(offerId, updateData);
    } catch (e) {
      throw Exception('Error updating offer: $e');
    }
  }

  @override
  Future<List<OfferModel>> fetchOffers({
    String? jobId,
    String? clientId,
    String? professionalId,
    String? status,
  }) async {
    try {
      return await remoteDataSource.fetchOffers(
        jobId: jobId,
        clientId: clientId,
        professionalId: professionalId,
        status: status,
      );
    } catch (e) {
      throw Exception('Error fetching offers: $e');
    }
  }


  @override
  Future<OfferModel> rejectOffer(String id) async {
    try {
      return await remoteDataSource.rejectOffer(id);
    } catch (e) {
      throw Exception('Error rejecting offer: $e');
    }
  }
}
