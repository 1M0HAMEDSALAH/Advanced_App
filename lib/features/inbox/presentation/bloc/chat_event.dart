import '../../data/models/message.dart';

abstract class ChatEvent {}

class LoadChatRooms extends ChatEvent {
  final int userId;
  LoadChatRooms(this.userId);
}

class LoadMessages extends ChatEvent {
  final int roomId;
  LoadMessages(this.roomId);
}

class SendMessage extends ChatEvent {
  final int roomId;
  final int senderId;
  final String content;

  SendMessage({
    required this.roomId,
    required this.senderId,
    required this.content,
  });
}

class MessageReceived extends ChatEvent {
  final Message message;
  MessageReceived(this.message);
}

// New events for stream management
class StartListeningToMessages extends ChatEvent {
  final int roomId;
  StartListeningToMessages(this.roomId);
}

class StopListeningToMessages extends ChatEvent {}
