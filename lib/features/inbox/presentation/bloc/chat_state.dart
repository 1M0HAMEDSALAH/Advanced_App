import '../../data/models/chat_room_model.dart';
import '../../data/models/message.dart';

abstract class ChatState {
  const ChatState();
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatRoom> chatRooms;

  const ChatLoaded(this.chatRooms);
}

class MessagesLoading extends ChatState {}

class MessagesLoaded extends ChatState {
  final List<Message> messages;

  const MessagesLoaded(this.messages);
}

class MessageSending extends ChatState {
  final List<Message> messages;

  const MessageSending(this.messages);
}

class MessageSent extends ChatState {
  final List<Message> messages;

  const MessageSent(this.messages);
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);
}
