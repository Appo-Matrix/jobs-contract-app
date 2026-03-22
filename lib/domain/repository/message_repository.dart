

import 'package:job_contract_app/data/models/chat/chat_model.dart';
import 'package:job_contract_app/data/models/chat/create_chat_res.dart';

import '../../data/models/chat/ChatModel2.dart';
import '../../data/models/messages/message_model.dart';

abstract class MessageRepository {

  Future<MessageModel> sendMessage(MessageModel message);

  Future<void> deleteMessage(String messageId);

  Future<MessageModel> updateMessage(String messageId, MessageModel message);

  Future<List<MessageModel>> getMessagesByChatId(String chatId);

  Future<MessageModel> markMessageAsRead(String messageId);

  Future<CreateChatResponse> createConversation(String otherUserId);

  Future<List<ChatModel2>> getConversations();

}
