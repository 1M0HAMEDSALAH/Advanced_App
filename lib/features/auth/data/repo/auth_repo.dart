import 'package:advanced_app/core/networking/api_service.dart';
import 'package:dio/dio.dart';

import '../../../../core/networking/endpoint.dart';
import '../../../../core/networking/main_resp.dart';
import '../models/auth.login.dart';
import '../models/auth.register.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository(this.apiService);

  Future<BaseResponse<AuthResponse>> login(
      String username, String password) async {
    try {
      final response = await apiService.post(
        EndPoints.login,
        data: {
          'Username': username,
          'Password': password,
        },
      );

      if (response.data == null) {
        throw const AuthException('Invalid response from server');
      }

      final baseResponse = BaseResponse<AuthResponse>.fromJson(
        response.data,
        (json) => AuthResponse.fromJson(json),
      );

      // ✅ نتحقق من status
      if (baseResponse.status != 'Success') {
        throw AuthException(baseResponse.message ?? 'Login failed');
      }

      // ✅ نخزن التوكن
      await apiService.updateToken(baseResponse.data.token);

      return baseResponse;
    } on DioException catch (e) {
      throw AuthException(
        e.response?.data?['message'] ?? 'Login failed. Please try again.',
      );
    } catch (e) {
      throw const AuthException('An unexpected error occurred');
    }
  }

  Future<BaseResponse<RegisterResponse>> register({
    required String fullName,
    required String gender,
    required String dateOfBirth,
    required String phoneNumber,
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        EndPoints.register,
        data: {
          'FullName': fullName,
          'Gender': gender,
          'DateOfBirth': dateOfBirth,
          'PhoneNumber': phoneNumber,
          'Email': email,
          'Username': username,
          'Password': password,
        },
      );

      if (response.data == null) {
        throw const AuthException('Invalid response from server');
      }

      final baseResponse = BaseResponse<RegisterResponse>.fromJson(
        response.data,
        (json) => RegisterResponse.fromJson(json),
      );

      return baseResponse;
    } on DioException catch (e) {
      throw AuthException(
        e.response?.data?['message'] ??
            'Registration failed. Please try again.',
      );
    } catch (e) {
      throw const AuthException('An unexpected error occurred');
    }
  }

  Future<void> logout() async {
    try {
      await apiService.post('/auth/logout');
      await apiService.clearToken();
    } catch (e) {
      throw const AuthException('Failed to logout');
    }
  }

  Future<Map<String, dynamic>> forgetPassword(String input) async {
    try {
      final response = await apiService.post(
        EndPoints.forgetPassword,
        data: {'input': input},
      );

      return response.data
          as Map<String, dynamic>; // Return the response to BLoC
    } on DioException catch (e) {
      throw AuthException(
        e.response?.data?['message'] ??
            'Forget password failed. Please try again.',
      );
    } catch (e) {
      throw const AuthException('An unexpected error occurred');
    }
  }

  Future<void> resetPassword(String newPassword, String userId) async {
    try {
      await apiService.post(
        EndPoints.resetPassword,
        data: {'userId': userId, 'newPassword': newPassword},
      );
    } on DioException catch (e) {
      throw AuthException(
        e.response?.data?['message'] ??
            'Reset password failed. Please try again.',
      );
    } catch (e) {
      throw const AuthException('An unexpected error occurred');
    }
  }
}

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}
