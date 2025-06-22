class RegisterResponse {
  final String message;
  final int userId;

  RegisterResponse({
    required this.message,
    required this.userId,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'],
      userId: json['userId'],
    );
  }
}

