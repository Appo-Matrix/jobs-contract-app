

import '../../data/models/messages/message_model.dart';

abstract class MessageRepository {

  Future<MessageModel> sendMessage(MessageModel message);

  Future<void> deleteMessage(String messageId);

  Future<MessageModel> updateMessage(String messageId, MessageModel message);

  Future<List<MessageModel>> getMessagesByChatId(String chatId);

  Future<MessageModel> markMessageAsRead(String messageId);


}
