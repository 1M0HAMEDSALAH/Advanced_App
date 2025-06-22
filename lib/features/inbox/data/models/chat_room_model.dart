class ChatRoom {
  final int roomId;
  final int user1Id;
  final int user2Id;
  final String createdAt;
  final String user1Name;
  final String user2Name;
  final String? user1Image;
  final String? user2Image;

  ChatRoom({
    required this.roomId,
    required this.user1Id,
    required this.user2Id,
    required this.createdAt,
    required this.user1Name,
    required this.user2Name,
    this.user1Image,
    this.user2Image,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      roomId: json['RoomID'] ?? 0,
      user1Id: json['User1ID'] ?? 0,
      user2Id: json['User2ID'] ?? 0,
      createdAt: json['CreatedAt'] ?? '',
      user1Name: json['User1']?['Username'] ?? '',
      user2Name: json['User2']?['Username'] ?? '',
      user1Image: json['User1']?['Party']?['ProfileImage'],
      user2Image: json['User2']?['Party']?['ProfileImage'],
    );
  }
}
