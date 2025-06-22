import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/message.dart';
import '../../presentation/bloc/chat_bloc.dart';
import '../../presentation/bloc/chat_event.dart';
import '../../presentation/bloc/chat_state.dart';

class ChatScreen extends StatefulWidget {
  final int roomId;
  final String receiverName;
  final int currentUserId;

  const ChatScreen({
    super.key,
    required this.roomId,
    required this.receiverName,
    required this.currentUserId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadMessages(widget.roomId));
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    context.read<ChatBloc>().add(SendMessage(
          roomId: widget.roomId,
          senderId: widget.currentUserId,
          content: _controller.text.trim(),
        ));

    _controller.clear();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverName)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: context.read<ChatBloc>().messageStream,
              builder: (context, snapshot) {
                final messages = snapshot.data ?? [];

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });

                if (messages.isEmpty) {
                  return const Center(child: Text('No messages yet'));
                }

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg.senderId == widget.currentUserId;
                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 4.h, horizontal: 12.w),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 14.w),
                        decoration: BoxDecoration(
                          color: isMe
                              ? Colors.lightBlueAccent.shade100
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          msg.content,
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              final isSending = state is MessageSending;
              return Column(
                children: [
                  if (isSending)
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: const Row(
                        children: [
                          CircularProgressIndicator(strokeWidth: 2),
                          SizedBox(width: 8),
                          Text('Sending...'),
                        ],
                      ),
                    ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    child: SafeArea(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              onSubmitted: (_) => _sendMessage(),
                              decoration: const InputDecoration(
                                hintText: 'Type a message...',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.send, color: Colors.white),
                              onPressed: _sendMessage,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
