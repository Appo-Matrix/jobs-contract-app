// data/repositories/chat_repository_impl.dart
import 'package:job_contracts/data/data_source/remote/chat_rds.dart';

import '../../domain/repository/chat_repository.dart';
import '../models/chat/chat_model.dart';
import '../models/chat/create_chat_req.dart';
import '../models/chat/create_chat_res.dart';
import '../models/chat/delete_chat_res.dart';


class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource=ChatRemoteDataSource();


  @override
  Future<CreateChatResponse> createChat(CreateChatRequest request) async {
    try {
      return await remoteDataSource.createChat(request);
    } catch (e) {
      rethrow;
    }
  }



  @override
  Future<DeleteChatResponse> deleteChatByJobId(String jobId) {
    try {
      return remoteDataSource.deleteChatByJobId(jobId);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<ChatModel>> getAllChats() {
    try {
      return remoteDataSource.getAllChats();
    }catch(e){
      rethrow;
    }
  }
}
