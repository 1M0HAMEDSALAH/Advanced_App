import 'package:advanced_app/features/auth/data/models/auth.login.dart';
import 'package:advanced_app/features/auth/logic/auth_event.dart';
import 'package:advanced_app/features/auth/logic/auth_state.dart';
import 'package:bloc/bloc.dart';

import '../data/repo/auth_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
    on<ForgetPasswordEvent>(_onForgetPassword);
    on<ResetPasswordEvent>(_onResetPassword);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final authResponse = await authRepository.login(
        event.username,
        event.password,
      );
      emit(LoginSuccess(authResponse.data));
      await authRepository.apiService.storeData(authResponse.data);
      emit(Authenticated(authResponse.data));
      if (authResponse.status == 'Error') {
        emit(AuthError(authResponse.message ?? 'Login failed'));
      }
    } on AuthException catch (e) {
      print("🔴 Login Error: ${e.message}"); // ✅ debug
      emit(AuthError(e.message));
    } catch (e) {
      print("⚠️ Unknown error: $e"); // ✅ debug
      emit(const AuthError('An unexpected error occurred'));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final registerResponse = await authRepository.register(
        fullName: event.fullName,
        gender: event.gender,
        dateOfBirth: event.dateOfBirth,
        phoneNumber: event.phoneNumber,
        email: event.email,
        username: event.username,
        password: event.password,
      );
      emit(RegistrationSuccess(registerResponse.data));
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(const AuthError('An unexpected error occurred'));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.logout();
      emit(Unauthenticated());
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(const AuthError('An unexpected error occurred'));
    }
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = authRepository.apiService.currentToken;
      if (token != null && token.isNotEmpty) {
        emit(Authenticated(
            authRepository.apiService.getAllData() as AuthResponse));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(const AuthError('Failed to check authentication status'));
    }
  }

  Future<void> _onForgetPassword(
    ForgetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final response = await authRepository.forgetPassword(event.input);

      final status = response['status'];
      final data = response['data'];
      final message = response['message'] ?? 'حدث خطأ';

      if (status == 'Success' && data != null && data['userId'] != null) {
        emit(ForgetPasswordSuccess(userId: data['userId']));
      } else {
        emit(AuthError(message));
      }
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(const AuthError('حدث خطأ غير متوقع. حاول مرة أخرى.'));
    }
  }

  Future<void> _onResetPassword(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final Respone =
          await authRepository.resetPassword(event.newPassword, event.userId);
      // if()
      emit(ResetPasswordSucsess());
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(const AuthError('An unexpected error occurred'));
    }
  }
}
