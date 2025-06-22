class UserData {
  final String username;
  final String email;
  final String imageCache;
  final int userId;
  final int partyId;

  UserData({
    required this.username,
    required this.email,
    required this.imageCache,
    required this.userId,
    required this.partyId,
  });

  factory UserData.empty() {
    return UserData(
      username: '',
      email: '',
      imageCache: '',
      userId: 0,
      partyId: 0,
    );
  }

  @override
  String toString() {
    return 'UserData(username: $username, email: $email, userId: $userId, partyId: $partyId)';
  }
}
