import 'package:flutter/material.dart';
import 'package:job_contracts/data/repositories/notification_repo_impl.dart';

import '../../../../data/models/notification/notification.dart';
import '../../../../data/models/notification/notification_setting_model.dart';
import '../../../../domain/repository/notification_repository.dart';

class NotificationProvider extends ChangeNotifier {

  final NotificationRepository repository= NotificationRepositoryImpl();


  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  int _unreadCount = 0;
  int get unreadCount => _unreadCount;

  bool isLoading = false;
  String? errorMessage;
  bool isSuccess = false;
  NotificationSettingsModel? settings;



  Future<void> fetchNotifications(String userId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      _notifications = await repository.getNotifications(userId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUnreadCount(String userId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      _unreadCount = await repository.getUnreadNotificationCount(userId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markAllNotificationsAsRead() async {
    isLoading = true;
    errorMessage = null;
    isSuccess = false;
    notifyListeners();

    try {
      await repository.markAllAsRead();
      isSuccess = true;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateNotificationSettings(NotificationSettingsModel model) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      settings = await repository.updateSettings(model);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
