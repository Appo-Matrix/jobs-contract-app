

import 'package:job_contract_app/data/models/chat/chat_model.dart';
import 'package:job_contract_app/data/models/chat/create_chat_res.dart';

import '../../domain/repository/message_repository.dart';
import '../data_source/remote/message_rds.dart';
import '../models/chat/ChatModel2.dart';
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
  Future<CreateChatResponse> createConversation(String otherUserId) async {
    try {
      return await remoteDataSource.createConversation(otherUserId);
    } catch (e) {
      throw Exception("Repository Error: $e");
    }
  }  @override
  Future<List<ChatModel2>> getConversations() async {
    try {
      return await remoteDataSource.getConversations();
    } catch (e) {
      throw Exception("Repository Error: $e");
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
