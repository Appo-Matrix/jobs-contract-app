import '../../data/models/offers/offer_model.dart';

abstract class OfferRepository {

  Future<OfferModel> acceptOffer(String offerId);

  Future<OfferModel> sendOffer(OfferModel offer);

  Future<void> deleteOffer(String offerId);

  Future<OfferModel> getOfferById(String offerId);

  Future<OfferModel> updateOffer(String offerId, Map<String, dynamic> updateData);

  Future<List<OfferModel>> fetchOffers({String? jobId, String? clientId, String? professionalId, String? status,});

  Future<OfferModel> rejectOffer(String id);



}
