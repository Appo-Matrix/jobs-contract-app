import '../../domain/repository/notification_repository.dart';
import '../data_source/remote/notification_rds.dart';
import '../models/notification/notification.dart';
import '../models/notification/notification_setting_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {

  final NotificationRemoteDataSource remoteDataSource = NotificationRemoteDataSource();


  @override
  Future<List<NotificationModel>> getNotifications(String userId) async {
    try {
      return await remoteDataSource.getNotifications(userId);
    } catch (e) {
      throw Exception('Error fetching notifications: $e');
    }
  }

  @override
  Future<int> getUnreadNotificationCount(String userId) async {
    try {
      return await remoteDataSource.getUnreadNotificationCount(userId);
    } catch (e) {
      throw Exception('Error getting unread count: $e');
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      return await remoteDataSource.markAllAsRead();
    } catch (e) {
      throw Exception('Error marking notifications as read: $e');
    }
  }


  @override
  Future<NotificationSettingsModel> updateSettings(NotificationSettingsModel model) async {
    try {
      return await remoteDataSource.updateSettings(model);
    } catch (e) {
      throw Exception('Error updating settings: $e');
    }
  }
}
