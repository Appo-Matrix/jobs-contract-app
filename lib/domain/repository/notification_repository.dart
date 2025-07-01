import '../../data/models/notification/notification.dart';
import '../../data/models/notification/notification_setting_model.dart';

abstract class NotificationRepository {

  Future<List<NotificationModel>> getNotifications(String userId);

  Future<int> getUnreadNotificationCount(String userId);

  Future<void> markAllAsRead();

  Future<NotificationSettingsModel> updateSettings(NotificationSettingsModel model);

}
