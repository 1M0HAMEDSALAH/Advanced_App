import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/message.dart';
import '../../data/repositories/chat_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repository;
  final List<Message> _currentMessages = [];
  final _messageController = StreamController<List<Message>>.broadcast();
  Stream<List<Message>> get messageStream => _messageController.stream;
  List<Message> _messages = [];
  StreamSubscription<Message>? _subscription;

  ChatBloc(this._repository) : super(ChatInitial()) {
    on<LoadChatRooms>(_onLoadChatRooms);
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<MessageReceived>(_onMessageReceived);
  }

  Future<void> _onLoadChatRooms(
    LoadChatRooms event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    try {
      final chatRooms = await _repository.getChatRooms(event.userId);
      emit(ChatLoaded(chatRooms));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onLoadMessages(
      LoadMessages event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    _messages = await _repository.getMessages(event.roomId);
    _messageController.add(_messages);
    emit(MessagesLoaded(_messages));

    _subscription = _repository.getMessageStream(event.roomId).listen((msg) {
      _messages.add(msg);
      _messageController.add(List.from(_messages));
    });
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    emit(MessageSending(_messages));
    await _repository.sendMessage(
      roomId: event.roomId,
      senderId: event.senderId,
      content: event.content,
    );
    emit(MessageSent(_messages));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _messageController.close();
    return super.close();
  }

  void _onMessageReceived(
    MessageReceived event,
    Emitter<ChatState> emit,
  ) {
    _currentMessages.add(event.message);
    emit(MessagesLoaded(List.from(_currentMessages)));
  }
}
