import '../../data/models/chat/chat_model.dart';
import '../../data/models/chat/create_chat_req.dart';
import '../../data/models/chat/create_chat_res.dart';
import '../../data/models/chat/delete_chat_res.dart';

abstract class ChatRepository {

  Future<CreateChatResponse> createChat(CreateChatRequest request);

  Future<DeleteChatResponse> deleteChatByJobId(String jobId);

  Future<List<ChatModel>> getAllChats();


}
