class EndPoints {
  static const String baseUrl = 'http://192.168.1.9:3000/api';

  static const String baseUrlImages = 'http://192.168.1.9:3000';

  static const String login = '/auth/login';

  static const String register = '/auth/register';

  static const String forgetPassword = '/auth/forget-password';

  static const String resetPassword = '/auth/reset-password';

  static const String getAllDoctors = '/doctors';
  static const String getAllDoctorsbyspecialit = '/doctors/specialization';
  static const String addReview = "/reviews";

  static const String uploadProfileImage = "/upload-image";

  static const String chatRooms = "/chat/rooms";

  static const String chatMessages = "/chat/messages";

  static const String sendMessage = "/chat/message";
}
