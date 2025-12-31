import 'package:job_contracts/core/constants/api_endpoints.dart';
import 'package:job_contracts/core/constants/global.dart';
import 'package:job_contracts/core/network/api_client.dart';

class AppServices {


  static Future<void> initialize() async {

    final apiClient = ApiClient(ApiPath.baseUrl);
    getIt.registerSingleton<ApiClient>(apiClient);

  }

}