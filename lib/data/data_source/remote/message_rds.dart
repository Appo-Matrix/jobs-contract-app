// data/remote/message_remote_data_source.dart
import 'package:job_contracts/core/constants/api_endpoints.dart';
import 'package:job_contracts/core/network/api_client.dart';

import '../../models/messages/message_model.dart';



class MessageRemoteDataSource {


  final ApiClient apiClient= ApiClient(ApiPath.baseUrl);


  Future<MessageModel> sendMessage(MessageModel message) async {
    final response = await apiClient.post(
      endpoint: ApiPath.sendMessage,
      data: message.toJson(),
    );

    if (response.statusCode == 200) {
      return MessageModel.fromJson(response.data['data']);
    } else if (response.statusCode == 400) {
      throw Exception(response.data['message'] ?? "Validation error");
    } else {
      throw Exception(response.data['message'] ?? "Failed to send message");
    }
  }

  Future<void> deleteMessage(String messageId) async {
    final response = await apiClient.delete(
      endpoint: ApiPath.deleteMessage(messageId),
    );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 404) {
      throw Exception("Message not found");
    } else {
      throw Exception(response.data['message'] ?? "Failed to delete message");
    }
  }

  Future<MessageModel> updateMessage(String messageId, MessageModel model) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updateMessage(messageId),
      data: model.toJson(),
    );

    if (response.statusCode == 200) {
      return MessageModel.fromJson(response.data['data']);
    } else if (response.statusCode == 404) {
      throw Exception("Message not found");
    } else {
      throw Exception(response.data['message'] ?? "Failed to update message");
    }
  }

  Future<List<MessageModel>> getMessagesByChatId(String chatId) async {
    final response = await apiClient.get(
       ApiPath.getMessagesByChatId(chatId),
    );

    if (response.statusCode == 200) {
      final List data = response.data['data'];
      return data.map((json) => MessageModel.fromJson(json)).toList();
    } else {
      throw Exception(response.data['message'] ?? "Failed to fetch messages");
    }
  }

  Future<MessageModel> markMessageAsRead(String messageId) async {
    final response = await apiClient.put(
      endpoint: '${ApiPath.markMessageAsRead}/$messageId',
    );

    if (response.statusCode == 200) {
      return MessageModel.fromJson(response.data['data']);
    } else if (response.statusCode == 404) {
      throw Exception("Message not found");
    } else {
      throw Exception("Failed to mark message as read");
    }
  }


}
