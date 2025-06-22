import 'dart:async';
import 'dart:convert';

import '../../../../core/networking/api_service.dart';
import '../../../../core/networking/endpoint.dart';
import '../models/chat_room_model.dart';
import '../models/message.dart';

class ChatRepository {
  final ApiService _apiService;

  ChatRepository(this._apiService);

  final _controller = StreamController<Message>.broadcast();

  Stream<Message> getMessageStream(int roomId) {
    return _controller.stream;
  }

  Future<List<ChatRoom>> getChatRooms(int userId) async {
    final response = await _apiService.get('/chat/rooms/$userId');
    final List<dynamic> roomsJson = response.data['rooms'] ?? [];
    return roomsJson
        .map((room) => ChatRoom.fromJson(room as Map<String, dynamic>))
        .toList();
  }

  Future<List<Message>> getMessages(int roomId) async {
    final response = await _apiService.get('/chat/messages/$roomId');
    final List<dynamic> messagesJson = response.data['messages'] ?? [];
    return messagesJson
        .map((msg) => Message.fromJson(msg as Map<String, dynamic>))
        .toList();
  }

  Future<Message> sendMessage({
    required int roomId,
    required int senderId,
    required String content,
  }) async {
    try {
      final response = await _apiService.post(
        EndPoints.sendMessage,
        data: json.encode({
          'roomId': roomId,
          'senderId': senderId,
          'message': content,
        }),
      );

      if (response.statusCode == 200) {
        final newMessage = Message.fromJson(response.data);
        _controller.add(newMessage); // ✅ أضف الرسالة هنا
        return newMessage;
      } else {
        throw Exception('Failed to send message');
      }
    } catch (e) {
      throw Exception('Error sending message: $e');
    }
  }
}
