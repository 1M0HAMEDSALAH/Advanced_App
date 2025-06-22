import 'package:equatable/equatable.dart';

import '../data/models/auth.login.dart';
import '../data/models/auth.register.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final AuthResponse authResponse;

  const LoginSuccess(this.authResponse);

  @override
  List<Object> get props => [authResponse];
}

class RegistrationSuccess extends AuthState {
  final RegisterResponse registerResponse;

  const RegistrationSuccess(this.registerResponse);

  @override
  List<Object> get props => [registerResponse];
}

class Authenticated extends AuthState {
  final AuthResponse authResponse;

  const Authenticated(this.authResponse);

  @override
  List<Object> get props => [authResponse];
}

class Unauthenticated extends AuthState {}

class ForgetPasswordSuccess extends AuthState {
  final int userId;

  ForgetPasswordSuccess({required this.userId});
}

class ResetPasswordSucsess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
