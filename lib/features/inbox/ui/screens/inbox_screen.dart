import 'package:advanced_app/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/bloc/chat_bloc.dart';
import '../../presentation/bloc/chat_event.dart';
import '../../presentation/bloc/chat_state.dart';
import 'chat_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  int? userId;
  bool isLoadingUserId = true;

  @override
  void initState() {
    super.initState();
    _initUserIdAndLoadChats();
  }

  Future<void> _initUserIdAndLoadChats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final idString = prefs.getString("UserId");

      if (idString != null && idString.isNotEmpty) {
        final parsedId = int.tryParse(idString);
        if (parsedId != null) {
          setState(() {
            userId = parsedId;
            isLoadingUserId = false;
          });
          _loadChats();
        } else {
          setState(() {
            isLoadingUserId = false;
          });
          _showUserIdError();
        }
      } else {
        setState(() {
          isLoadingUserId = false;
        });
        _showUserIdError();
      }
    } catch (e) {
      setState(() {
        isLoadingUserId = false;
      });
      _showUserIdError();
    }
  }

  void _loadChats() {
    if (userId != null) {
      context.read<ChatBloc>().add(LoadChatRooms(userId!));
    }
  }

  void _showUserIdError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('User ID not found. Please log in again.'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoadingUserId
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading user data...'),
                ],
              ),
            )
          : userId == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_off, size: 64.w, color: Colors.grey),
                      SizedBox(height: 16.h),
                      Text(
                        'User not found',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Please log in to access your chats',
                        style:
                            TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to login screen
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text('Go to Login'),
                      ),
                    ],
                  ),
                )
              : BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is ChatError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                size: 48.w, color: Colors.red),
                            SizedBox(height: 16.h),
                            Text(
                              'Error loading chats',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.sp),
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed: _loadChats,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is ChatLoaded) {
                      if (state.chatRooms.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.chat_bubble_outline,
                                  size: 64.w, color: Colors.grey),
                              SizedBox(height: 16.h),
                              Text(
                                'No chats yet',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Start a conversation to see your chats here',
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.grey[600]),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 30.h, bottom: 8.h),
                            child: Center(
                              child: Text(
                                'Inbox',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async => _loadChats(),
                              child: ListView.separated(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                itemCount: state.chatRooms.length,
                                separatorBuilder: (_, __) => Divider(
                                  height: 1.h,
                                  color: Colors.grey[300],
                                ),
                                itemBuilder: (context, index) {
                                  final chat = state.chatRooms[index];
                                  final otherName = chat.user1Id == userId!
                                      ? chat.user2Name
                                      : chat.user1Name;

                                  return ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 8.h,
                                    ),
                                    leading: CircleAvatar(
                                      radius: 24.r,
                                      backgroundColor: Colors.blue.shade100,
                                      backgroundImage: (chat.user1Id == userId!
                                                      ? chat.user2Image
                                                      : chat.user1Image) !=
                                                  null &&
                                              (chat.user1Id == userId!
                                                      ? chat.user2Image
                                                      : chat.user1Image)!
                                                  .isNotEmpty
                                          ? NetworkImage(
                                              'http://192.168.1.9:3000${chat.user1Id == userId! ? chat.user2Image : chat.user1Image}')
                                          : null,
                                      child: ((chat.user1Id == userId!
                                                      ? chat.user2Image
                                                      : chat.user1Image) ==
                                                  null ||
                                              (chat.user1Id == userId!
                                                      ? chat.user2Image
                                                      : chat.user1Image)!
                                                  .isEmpty)
                                          ? Text(
                                              otherName.isNotEmpty
                                                  ? otherName[0].toUpperCase()
                                                  : '?',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                              ),
                                            )
                                          : null,
                                    ),
                                    title: Text(
                                      otherName.isNotEmpty
                                          ? otherName
                                          : 'Unknown User',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      _formatDate(chat.createdAt),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey[600],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: Colors.grey[400],
                                      size: 20.sp,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ChatScreen(
                                            roomId: chat.roomId,
                                            receiverName: otherName.isNotEmpty
                                                ? otherName
                                                : 'Unknown User',
                                            currentUserId: userId!,
                                          ),
                                        ),
                                      ).then((_) => _loadChats());
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {
      return dateString;
    }
  }
}
