import 'package:dio/dio.dart';
import 'package:job_contracts/core/constants/api_endpoints.dart';
import 'package:job_contracts/core/network/api_client.dart';

import '../../models/portfolios/portfolio_create_req.dart';
import '../../models/portfolios/portfolio_entry_model.dart';
import '../../models/portfolios/update_portfolio_req.dart';

class PortfolioRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<String> createPortfolio(PortfolioCreateRequest request) async {
    final formData = FormData.fromMap({
      'before': await MultipartFile.fromFile(request.beforeImage.path, filename: 'before.jpg'),
      'after': await MultipartFile.fromFile(request.afterImage.path, filename: 'after.jpg'),
      'description': request.description,
      'cost': request.cost,
      'serviceTime': request.serviceTime,
    });

    final response = await apiClient.postMultipart(
      endpoint: ApiPath.createPortfolio,
      data: formData,
    );

    switch (response.statusCode) {
      case 201:
        return response.data.toString(); // Server returns a string message
      case 400:
        throw Exception(response.data['error'] ?? 'Validation failed');
      case 500:
        throw Exception(response.data['error'] ?? 'Internal server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }


  Future<List<PortfolioEntryModel>> getAllPortfolios() async {
    final response = await apiClient.get(ApiPath.getAllPortfolios);

    switch (response.statusCode) {
      case 200:
        return (response.data as List)
            .map((json) => PortfolioEntryModel.fromJson(json))
            .toList();
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<String> deletePortfolio(String id) async {
    final response = await apiClient.delete(
      endpoint: ApiPath.deletePortfolio(id),
    );

    switch (response.statusCode) {
      case 200:
        return response.data['message'] ?? 'Portfolio deleted successfully';
      case 404:
        throw Exception(response.data['error'] ?? 'Portfolio not found');
      case 500:
        throw Exception(response.data['error'] ?? 'Something went wrong');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<PortfolioEntryModel> getPortfolioById(String id) async {
    final response = await apiClient.get(
      ApiPath.getPortfolioById(id),
    );

    switch (response.statusCode) {
      case 200:
        return PortfolioEntryModel.fromJson(response.data);
      case 404:
        throw Exception(response.data['error'] ?? 'Portfolio not found');
      case 500:
        throw Exception(response.data['error'] ?? 'Unable to retrieve portfolio');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }


  Future<String> updatePortfolio(String id, UpdatePortfolioRequestModel data) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updatePortfolio(id),
      data: data.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return response.data ?? "Portfolio updated successfully";
      case 400:
        throw Exception(response.data['error'] ?? 'Invalid data');
      case 404:
        throw Exception(response.data['error'] ?? 'Portfolio not found');
      case 500:
        throw Exception(response.data['error'] ?? 'Unable to update portfolio');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }
}
