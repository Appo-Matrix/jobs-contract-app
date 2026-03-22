// // provider/message_provider.dart
//
// import 'package:flutter/material.dart';
// import 'package:job_contract_app/data/models/chat/chat_model.dart';
// import 'package:job_contract_app/data/models/chat/create_chat_res.dart';
// import 'package:job_contract_app/data/repositories/message_repository_impl.dart';
// import '../../../../data/models/chat/ChatModel2.dart';
// import '../../../../data/models/messages/message_model.dart';
// import '../../../../domain/repository/message_repository.dart';
//
// class MessageProvider with ChangeNotifier {
//   final MessageRepository repository = MessageRepositoryImpl();
//
//
//   // ================== MESSAGE STATES ==================
//   MessageModel? sentMessage;
//   MessageModel? updatedMessage;
//   List<MessageModel> messages = [];
//
//   // ================== CONVERSATION STATE ==================
//   CreateChatResponse? conversationResponse;
//
//   // ================== COMMON STATES ==================
//   bool isLoading = false;
//   String? errorMessage;
//   List<ChatModel2> conversations = [];
//
//   // ================== SEND MESSAGE ==================
//   Future<void> sendMessage(MessageModel message) async {
//     // 1. Optimistic update — show message instantly, no loading spinner
//     final optimistic = message.copyWith(
//       id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
//       createdAt: DateTime.now(),
//     );
//     messages = [...messages, optimistic];
//     errorMessage = null;
//     notifyListeners(); // ← UI rebuilds immediately with the new message
//
//     try {
//       sentMessage = await repository.sendMessage(message);
//
//       // 2. Replace temp with real message returned from server
//       messages = messages
//           .map((m) => m.id == optimistic.id ? sentMessage! : m)
//           .toList();
//     } catch (e) {
//       // 3. On failure, roll back the optimistic message
//       messages = messages.where((m) => m.id != optimistic.id).toList();
//       errorMessage = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//   //
//   // // ================== SEND MESSAGE ==================
//   // Future<void> sendMessage(MessageModel message) async {
//   //   isLoading = true;
//   //   errorMessage = null;
//   //   notifyListeners();
//   //
//   //   try {
//   //     sentMessage = await repository.sendMessage(message);
//   //   } catch (e) {
//   //     errorMessage = e.toString();
//   //   } finally {
//   //     isLoading = false;
//   //     notifyListeners();
//   //   }
//   // }
//   Future<void> fetchConversations() async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();
//
//     try {
//       conversations = await repository.getConversations();
//     } catch (e) {
//       errorMessage = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//   // ================== CREATE CONVERSATION ==================
//   Future<void> createConversation(String otherUserId) async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();
//
//     try {
//       conversationResponse =
//       await repository.createConversation(otherUserId);
//     } catch (e) {
//       errorMessage = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   // ================== DELETE MESSAGE ==================
//   Future<void> deleteMessage(String messageId) async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();
//
//     try {
//       await repository.deleteMessage(messageId);
//     } catch (e) {
//       errorMessage = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   // ================== UPDATE MESSAGE ==================
//   Future<void> updateMessage(String messageId, MessageModel message) async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();
//
//     try {
//       updatedMessage =
//       await repository.updateMessage(messageId, message);
//     } catch (e) {
//       errorMessage = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   // ================== FETCH MESSAGES ==================
//   Future<void> fetchMessagesByChatId(String chatId) async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();
//
//     try {
//       messages = await repository.getMessagesByChatId(chatId);
//     } catch (e) {
//       errorMessage = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   // ================== MARK AS READ ==================
//   Future<void> markAsRead(String messageId) async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       updatedMessage =
//       await repository.markMessageAsRead(messageId);
//       errorMessage = null;
//     } catch (e) {
//       errorMessage = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:job_contract_app/data/models/chat/create_chat_res.dart';
import 'package:job_contract_app/data/repositories/message_repository_impl.dart';
import '../../../../config/dependencies/SocketService.dart';
import '../../../../data/models/chat/ChatModel2.dart';
import '../../../../data/models/messages/message_model.dart';
import '../../../../domain/repository/message_repository.dart';

class MessageProvider with ChangeNotifier {
  final MessageRepository repository = MessageRepositoryImpl();
  final SocketService _socket = SocketService();

  // ================== MESSAGE STATES ==================
  MessageModel? sentMessage;
  MessageModel? updatedMessage;
  List<MessageModel> messages = [];
  String? _currentChatId;

  // ================== CONVERSATION STATE ==================
  CreateChatResponse? conversationResponse;

  // ================== COMMON STATES ==================
  bool isLoading = false;
  String? errorMessage;
  List<ChatModel2> conversations = [];

  // ================== SOCKET INIT ==================
  void initSocket(String token) {
    _socket.connect(token);

    _socket.onNewMessage = (data) {
      try {
        final raw = data['message'] ?? data;
        final message = MessageModel.fromJson(raw as Map<String, dynamic>);

        // Only append if it belongs to the currently open chat
        if (message.conversationId == _currentChatId) {
          // Avoid duplicates (optimistic message already added)
          final alreadyExists = messages.any((m) => m.id == message.id);
          if (!alreadyExists) {
            messages = [...messages, message];
            notifyListeners();
          }
        }

        // Update conversation last message
        final index = conversations.indexWhere(
              (c) => c.id == message.conversationId,
        );
        if (index != -1) {
          // You can update lastMessage on ChatModel2 here if your model supports it
          notifyListeners();
        }
      } catch (e) {
        debugPrint('❌ Error parsing incoming socket message: $e');
      }
    };
  }

  void leaveChat() {
    if (_currentChatId != null) {
      _socket.leaveConversation(_currentChatId!);
      _currentChatId = null;
    }
  }

  void disconnectSocket() {
    _socket.disconnect();
  }

  // ================== SEND MESSAGE ==================
  Future<void> sendMessage(MessageModel message) async {
    // 1. Optimistic update — show message instantly
    final optimistic = message.copyWith(
      id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
    );
    messages = [...messages, optimistic];
    errorMessage = null;
    notifyListeners();

    try {
      sentMessage = await repository.sendMessage(message);

      // 2. Replace temp with real message from server
      if (sentMessage != null) {
        messages = messages
            .map((m) => m.id == optimistic.id ? sentMessage! : m)
            .toList();
      }
    } catch (e) {
      // 3. Roll back optimistic message on failure
      messages = messages.where((m) => m.id != optimistic.id).toList();
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ================== FETCH MESSAGES ==================
  Future<void> fetchMessagesByChatId(String chatId) async {
    _currentChatId = chatId;
    _socket.joinConversation(chatId); // ← join socket room

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

  // ================== FETCH CONVERSATIONS ==================
  Future<void> fetchConversations() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      conversations = await repository.getConversations();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ================== CREATE CONVERSATION ==================
  Future<void> createConversation(String otherUserId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      conversationResponse = await repository.createConversation(otherUserId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ================== DELETE MESSAGE ==================
  Future<void> deleteMessage(String messageId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await repository.deleteMessage(messageId);
      // Remove from local list immediately
      messages = messages.where((m) => m.id != messageId).toList();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ================== UPDATE MESSAGE ==================
  Future<void> updateMessage(String messageId, MessageModel message) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      updatedMessage = await repository.updateMessage(messageId, message);
      if (updatedMessage != null) {
        messages = messages
            .map((m) => m.id == messageId ? updatedMessage! : m)
            .toList();
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ================== MARK AS READ ==================
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