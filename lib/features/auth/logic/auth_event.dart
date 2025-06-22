import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class RegisterEvent extends AuthEvent {
  final String fullName;
  final String gender;
  final String dateOfBirth;
  final String phoneNumber;
  final String email;
  final String username;
  final String password;

  const RegisterEvent({
    required this.fullName,
    required this.gender,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [
        fullName,
        gender,
        dateOfBirth,
        phoneNumber,
        email,
        username,
        password,
      ];
}

class LogoutEvent extends AuthEvent {}

class ForgetPasswordEvent extends AuthEvent {
  final String input;

  const ForgetPasswordEvent({required this.input});

  @override
  List<Object> get props => [input];
}

class ResetPasswordEvent extends AuthEvent {
  final String userId;
  final String newPassword;

  const ResetPasswordEvent({required this.newPassword, required this.userId});

  @override
  List<Object> get props => [newPassword];
}

class CheckAuthStatusEvent extends AuthEvent {}
