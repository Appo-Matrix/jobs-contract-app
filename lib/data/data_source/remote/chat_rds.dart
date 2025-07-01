// data/data_source/remote/chat_remote_data_source.dart
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/chat/chat_model.dart';
import '../../models/chat/create_chat_req.dart';
import '../../models/chat/create_chat_res.dart';
import '../../models/chat/delete_chat_res.dart';


class ChatRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<CreateChatResponse> createChat(CreateChatRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.createChat,
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 201:
        return CreateChatResponse.fromJson(response.data);
      case 400:
        throw Exception("Invalid request data");
      case 500:
      default:
        throw Exception(response.data['message'] ?? "Server error");
    }
  }




  Future<DeleteChatResponse> deleteChatByJobId(String jobId) async {
    final response = await apiClient.delete(endpoint: '${ApiPath.deleteChatByJobId}/$jobId');

    switch (response.statusCode) {
      case 200:
        return DeleteChatResponse.fromJson(response.data);
      case 404:
        throw Exception("Chat not found");
      case 500:
      default:
        throw Exception(response.data['message'] ?? "Server error");
    }
  }

  Future<List<ChatModel>> getAllChats() async {
    final response = await apiClient.get(ApiPath.getAllChats);

    switch (response.statusCode) {
      case 200:
        return (response.data as List)
            .map((e) => ChatModel.fromJson(e))
            .toList();
      case 400:
        throw Exception("Invalid user ID");
      case 401:
        throw Exception("Unauthorized access");
      default:
        throw Exception(response.data['error'] ?? "Server error");
    }
  }
}
