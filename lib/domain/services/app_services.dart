
import '../../core/constants/api_endpoints.dart';
import '../../core/constants/global.dart';
import '../../core/network/api_client.dart';

class AppServices {


  static Future<void> initialize() async {

    final apiClient = ApiClient(ApiPath.baseUrl);
    getIt.registerSingleton<ApiClient>(apiClient);

  }

}