import '../../data/models/portfolios/portfolio_create_req.dart';
import '../../data/models/portfolios/portfolio_entry_model.dart';
import '../../data/models/portfolios/update_portfolio_req.dart';

abstract class PortfolioRepository {

  Future<String> createPortfolio(PortfolioCreateRequest request);

  Future<List<PortfolioEntryModel>> getAllPortfolios();

  Future<String> deletePortfolio(String id);

  Future<PortfolioEntryModel> getPortfolioById(String id);

  Future<String> updatePortfolio(String id, UpdatePortfolioRequestModel model);


}
