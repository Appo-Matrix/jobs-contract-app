import 'package:job_contracts/data/data_source/remote/portfolio_rds.dart';

import '../../domain/repository/portfolio_repository.dart';
import '../models/portfolios/portfolio_create_req.dart';
import '../models/portfolios/portfolio_entry_model.dart';
import '../models/portfolios/update_portfolio_req.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioRemoteDataSource remoteDataSource = PortfolioRemoteDataSource();



  @override
  Future<String> createPortfolio(PortfolioCreateRequest request) async {
    try {
      return await remoteDataSource.createPortfolio(request);
    } catch (e) {
      throw Exception('Failed to create portfolio: ${e.toString()}');
    }
  }

  @override
  Future<List<PortfolioEntryModel>> getAllPortfolios() async {
    try {
      return await remoteDataSource.getAllPortfolios();
    } catch (e) {
      throw Exception('Failed to fetch portfolios: ${e.toString()}');
    }
  }


  @override
  Future<String> deletePortfolio(String id) async {
    try {
      return await remoteDataSource.deletePortfolio(id);
    } catch (e) {
      throw Exception('Failed to delete portfolio: ${e.toString()}');
    }
  }

  @override
  Future<PortfolioEntryModel> getPortfolioById(String id) async {
    try {
      return await remoteDataSource.getPortfolioById(id);
    } catch (e) {
      throw Exception('Failed to load portfolio: ${e.toString()}');
    }
  }

  @override
  Future<String> updatePortfolio(String id, UpdatePortfolioRequestModel model) async {
    try {
      return await remoteDataSource.updatePortfolio(id, model);
    } catch (e) {
      throw Exception('Failed to update portfolio: ${e.toString()}');
    }
  }
}
