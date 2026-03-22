import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  IO.Socket? _socket;
  Function(Map<String, dynamic>)? onNewMessage;

  void connect(String token) {
    if (_socket?.connected == true) return;

    _socket = IO.io(
      'http://167.99.118.43:8000',
      IO.OptionBuilder()
          .setTransports(['polling']) // ← matches your web client
          .disableAutoConnect()
          .setAuth({'token': token})
          .build(),
    );

    _socket!.connect();

    _socket!.on('connect', (_) {
      print('✅ Socket connected');
    });

    _socket!.on('disconnect', (_) {
      print('❌ Socket disconnected');
    });

    _socket!.on('new_message', (data) {
      print('📩 new_message received: $data');
      if (onNewMessage != null && data is Map<String, dynamic>) {
        onNewMessage!(data);
      }
    });
  }

  void joinConversation(String conversationId) {
    _socket?.emit('join_conversation', {'conversationId': conversationId});
  }

  void leaveConversation(String conversationId) {
    _socket?.emit('leave_conversation', {'conversationId': conversationId});
  }

  void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }
}