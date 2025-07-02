import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../data/models/portfolios/portfolio_create_req.dart';
import '../../../../data/models/portfolios/portfolio_entry_model.dart';
import '../../../../data/models/portfolios/update_portfolio_req.dart';
import '../../../../data/repositories/portfolio_repo_impl.dart';
import '../../../../domain/repository/portfolio_repository.dart';

class PortfolioProvider extends ChangeNotifier {
  final PortfolioRepository repository = PortfolioRepositoryImpl();

  bool _isLoading = false;
  String _errorMessage = '';
  String _successMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;

  List<PortfolioEntryModel> _portfolios = [];
  List<PortfolioEntryModel> get portfolios => _portfolios;



  Future<void> createPortfolio({
    required File beforeImage,
    required File afterImage,
    required String description,
    required double cost,
    required int serviceTime,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    _successMessage = '';
    notifyListeners();

    try {
      final request = PortfolioCreateRequest(
        beforeImage: beforeImage,
        afterImage: afterImage,
        description: description,
        cost: cost,
        serviceTime: serviceTime,
      );
      final response = await repository.createPortfolio(request);
      _successMessage = response;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchPortfolios() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _portfolios = await repository.getAllPortfolios();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePortfolio(String id) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await repository.deletePortfolio(id);
      _portfolios.removeWhere((portfolio) => portfolio.id == id);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  PortfolioEntryModel? _selectedPortfolio;

  PortfolioEntryModel? get selectedPortfolio => _selectedPortfolio;

  Future<void> fetchPortfolioById(String id) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _selectedPortfolio = await repository.getPortfolioById(id);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String? _updateMessage;
  String? get updateMessage => _updateMessage;

  Future<void> updatePortfolio(String id, UpdatePortfolioRequestModel model) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final message = await repository.updatePortfolio(id, model);
      _updateMessage = message;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
