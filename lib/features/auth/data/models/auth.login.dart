class AuthResponse {
  final String token;
  final AuthUser user;

  AuthResponse({
    required this.token,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      user: AuthUser.fromJson(json['user']),
    );
  }
}

class AuthUser {
  final int userId;
  final String username;
  final String passwordHash;
  final bool isActive;
  final String createdAt;
  final int partyId;
  final Party party;

  AuthUser({
    required this.userId,
    required this.username,
    required this.passwordHash,
    required this.isActive,
    required this.createdAt,
    required this.partyId,
    required this.party,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      userId: json['UserID'],
      username: json['Username'],
      passwordHash: json['PasswordHash'],
      isActive: json['IsActive'],
      createdAt: json['CreatedAt'],
      partyId: json['PartyID'],
      party: Party.fromJson(json['Party']),
    );
  }
}

class Party {
  final int partyId;
  final String fullName;
  final String gender;
  final String dateOfBirth;
  final String phoneNumber;
  final String email;
  final String? image;

  Party(
      {required this.partyId,
      required this.fullName,
      required this.gender,
      required this.dateOfBirth,
      required this.phoneNumber,
      required this.email,
      this.image});

  factory Party.fromJson(Map<String, dynamic> json) {
    return Party(
        partyId: json['PartyID'],
        fullName: json['FullName'],
        gender: json['Gender'],
        dateOfBirth: json['DateOfBirth'],
        phoneNumber: json['PhoneNumber'],
        email: json['Email'],
        image: json['ProfileImage'] == null || json['ProfileImage'] == ''
            ? null
            : json['ProfileImage']);
  }
}
