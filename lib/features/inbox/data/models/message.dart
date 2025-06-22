class Message {
  final int id;
  final int roomId;
  final int senderId;
  final String content;
  final String createdAt;
  final String senderName;

  Message({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.content,
    required this.createdAt,
    required this.senderName,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['ID'] ?? 0,
      roomId: json['RoomID'] ?? 0,
      senderId: json['SenderID'] ?? 0,
      content: json['Message'] ?? '',
      createdAt: json['CreatedAt'] ?? '',
      senderName: json['SenderName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'RoomID': roomId,
      'SenderID': senderId,
      'Content': content,
      'CreatedAt': createdAt,
      'SenderName': senderName,
    };
  }
}
