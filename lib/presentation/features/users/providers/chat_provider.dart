// providers/chat_provider.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_contracts/data/repositories/chat_repository_impl.dart';

import '../../../../data/models/chat/chat_model.dart';
import '../../../../data/models/chat/create_chat_req.dart';
import '../../../../domain/repository/chat_repository.dart';


class ChatProvider with ChangeNotifier {
  final ChatRepository _chatRepository=ChatRepositoryImpl();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSending = false;
  bool get isSending => _isSending;

  Future<void> sendChatMessage(CreateChatRequest request) async {
    try {
      _isSending = true;
      notifyListeners();

      final response = await _chatRepository.createChat(request);

      Fluttertoast.showToast(
        msg: "Message sent!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // You can append to a local chat list here if needed
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error sending message: ${e.toString()}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      _isSending = false;
      notifyListeners();
    }
  }



  bool _isDeleting = false;
  bool get isDeleting => _isDeleting;

  Future<void> deleteChatByJobId(String jobId) async {
    try {
      _isDeleting = true;
      notifyListeners();

      final response = await _chatRepository.deleteChatByJobId(jobId);

      Fluttertoast.showToast(
        msg: response.message,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error deleting chat: ${e.toString()}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      _isDeleting = false;
      notifyListeners();
    }
  }


  List<ChatModel> _chats = [];
  List<ChatModel> get chats => _chats;

  String? _error;
  String? get error => _error;

  Future<void> fetchChats() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _chats = await _chatRepository.getAllChats();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
