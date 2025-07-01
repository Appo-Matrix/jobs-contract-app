// provider/message_provider.dart
import 'package:flutter/material.dart';
import 'package:job_contracts/data/repositories/message_repository_impl.dart';

import '../../../../data/models/messages/message_model.dart';
import '../../../../domain/repository/message_repository.dart';

class MessageProvider with ChangeNotifier {
  final MessageRepository repository= MessageRepositoryImpl();


  MessageModel? sentMessage;
  bool isLoading = false;
  String? errorMessage;

  MessageModel? updatedMessage;

  List<MessageModel> messages = [];


  Future<void> sendMessage(MessageModel message) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      sentMessage = await repository.sendMessage(message);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteMessage(String messageId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await repository.deleteMessage(messageId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateMessage(String messageId, MessageModel message) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      updatedMessage = await repository.updateMessage(messageId, message);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMessagesByChatId(String chatId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      messages = await repository.getMessagesByChatId(chatId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markAsRead(String messageId) async {
    isLoading = true;
    notifyListeners();

    try {
      updatedMessage = await repository.markMessageAsRead(messageId);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
