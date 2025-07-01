import 'package:job_contracts/core/constants/api_endpoints.dart';
import 'package:job_contracts/core/network/api_client.dart';

import '../../models/notification/notification.dart';
import '../../models/notification/notification_setting_model.dart';

class NotificationRemoteDataSource {

  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<List<NotificationModel>> getNotifications(String userId) async {
    final response = await apiClient.get(
       '${ApiPath.getNotificationsByUser}/$userId',
    );

    if (response.statusCode == 200) {
      final List data = response.data['notifications'];
      return data.map((json) => NotificationModel.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      throw Exception('No notifications found');
    } else {
      throw Exception('Failed to fetch notifications');
    }
  }

  Future<int> getUnreadNotificationCount(String userId) async {
    final response = await apiClient.get(
       ApiPath.unreadNotificationCount,
      queryParameters: {'userId': userId},
    );

    if (response.statusCode == 200) {
      return response.data['count'] ?? 0;
    } else if (response.statusCode == 400) {
      throw Exception(response.data['message'] ?? 'User ID is required');
    } else {
      throw Exception(response.data['error'] ?? 'Server error');
    }
  }

  Future<void> markAllAsRead() async {
    final response = await apiClient.put(endpoint: ApiPath.markAllNotificationsAsRead);

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      throw Exception(response.data['message'] ?? 'Unauthorized');
    } else {
      throw Exception(response.data['error'] ?? 'Error updating unread count');
    }
  }

  Future<NotificationSettingsModel> updateSettings(NotificationSettingsModel model) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updateNotificationSettings,
      data: model.toJson(),
    );

    if (response.statusCode == 200) {
      return NotificationSettingsModel.fromJson(response.data['data']);
    } else if (response.statusCode == 400 || response.statusCode == 401 || response.statusCode == 404) {
      throw Exception(response.data['message'] ?? 'Failed to update settings');
    } else {
      throw Exception(response.data['error'] ?? 'Server error');
    }
  }
}
