

import '../../domain/repository/message_repository.dart';
import '../data_source/remote/message_rds.dart';
import '../models/messages/message_model.dart';


class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource remoteDataSource= MessageRemoteDataSource();


  @override
  Future<MessageModel> sendMessage(MessageModel message) async {
    try {
      return await remoteDataSource.sendMessage(message);
    } catch (e) {
      throw Exception('Error sending message: $e');
    }
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    try {
      return await remoteDataSource.deleteMessage(messageId);
    } catch (e) {
      throw Exception('Error deleting message: $e');
    }
  }


  @override
  Future<MessageModel> updateMessage(String messageId, MessageModel message) async {
    try {
      return await remoteDataSource.updateMessage(messageId, message);
    } catch (e) {
      throw Exception('Error updating message: $e');
    }
  }

  @override
  Future<List<MessageModel>> getMessagesByChatId(String chatId) async {
    try {
      return await remoteDataSource.getMessagesByChatId(chatId);
    } catch (e) {
      throw Exception('Error fetching messages: $e');
    }
  }

  @override
  Future<MessageModel> markMessageAsRead(String messageId) async {
    try {
      return await remoteDataSource.markMessageAsRead(messageId);
    } catch (e) {
      throw Exception('Error marking message as read: $e');
    }
  }
}
