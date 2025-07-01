import 'package:flutter/material.dart';
import 'package:job_contracts/data/repositories/offer_repo_impl.dart';

import '../../../../data/models/offers/offer_model.dart';
import '../../../../domain/repository/offer_repository.dart';

class OfferProvider extends ChangeNotifier {
  final OfferRepository repository = OfferRepositoryImpl();

  bool isLoading = false;
  String? errorMessage;
  OfferModel? acceptedOffer;
  OfferModel? createdOffer;

  OfferModel? _offer;
  OfferModel? get offer => _offer;

  OfferModel? updatedOffer;

  List<OfferModel> offers = [];







  Future<void> acceptOffer(String offerId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await repository.acceptOffer(offerId);
      acceptedOffer = result;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendOffer(OfferModel offer) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await repository.sendOffer(offer);
      createdOffer = result;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> deleteOffer(String offerId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await repository.deleteOffer(offerId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchOfferById(String offerId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await repository.getOfferById(offerId);
      _offer = result;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateOffer(String offerId, Map<String, dynamic> updateData) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      updatedOffer = await repository.updateOffer(offerId, updateData);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchOffers({
    String? jobId,
    String? clientId,
    String? professionalId,
    String? status,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      offers = await repository.fetchOffers(
        jobId: jobId,
        clientId: clientId,
        professionalId: professionalId,
        status: status,
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> rejectOffer(String id) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await repository.rejectOffer(id);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
