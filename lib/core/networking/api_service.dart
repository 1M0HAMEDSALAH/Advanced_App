import 'dart:developer';
import 'dart:io';

import 'package:advanced_app/core/networking/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/models/auth.login.dart';

class ApiService {
  static const String _tokenKey = 'userToken';
  static const Duration _connectTimeout = Duration(seconds: 30);
  static const Duration _receiveTimeout = Duration(seconds: 30);
  static const Duration _sendTimeout = Duration(seconds: 30);
  static const int _maxRetries = 3;

  late final Dio _dio;
  late final SharedPreferences _prefs;

  // Singleton instance
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  /// Initializes the API service with required dependencies
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await _initializeDio();
  }

  Future<void> _initializeDio() async {
    _dio = Dio(BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      validateStatus: (status) => status != null && status < 500,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _addInterceptors();
  }

  void _addInterceptors() {
    _dio.interceptors.addAll([
      _AuthInterceptor(_prefs),
      if (kDebugMode) _LoggingInterceptor(),
      _RetryInterceptor(_dio, maxRetries: _maxRetries),
      _ErrorHandlingInterceptor(_prefs),
    ]);
  }

  /// Returns whether the user is currently authenticated
  bool get isAuthenticated {
    final token = _prefs.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }

  /// Gets the current authentication token
  String? get currentToken => _prefs.getString(_tokenKey);

  /// Updates the authentication token
  Future<void> updateToken(String newToken) async {
    await _prefs.setString(_tokenKey, newToken);
  }

  // add all data from the SharedPreferences
  Future<Map<String, dynamic>> get allData async {
    final keys = _prefs.getKeys();
    final data = <String, dynamic>{};
    for (final key in keys) {
      data[key] = _prefs.get(key);
    }
    return data;
  }

  // get all data from the SharedPreferences
  Future<Map<String, dynamic>> getAllData() async {
    final keys = _prefs.getKeys();
    final data = <String, dynamic>{};
    for (final key in keys) {
      data[key] = _prefs.get(key);
    }
    return data;
  }

  /// Clears the authentication token
  Future<void> clearToken() async {
    await _prefs.remove(_tokenKey);
    await _prefs.clear(); // Clear all data from SharedPreferences
  }

  Future<void> storeData(AuthResponse authResponse) async {
    // TODO: Implement storing user data in SharedPreferences
    await _prefs.setString("Username", authResponse.user.username);
    await _prefs.setString("Email", authResponse.user.party.email);
    await _prefs.setString("Image", authResponse.user.party.image ?? "");
    await _prefs.setString("Gender", authResponse.user.party.gender);
    await _prefs.setString("PhoneNumber", authResponse.user.party.phoneNumber);
    await _prefs.setString("PartyId", authResponse.user.partyId.toString());
    await _prefs.setString("UserId", authResponse.user.userId.toString());
    log("User data stored in SharedPreferences");
  }

  /// Makes a GET request to the specified endpoint
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Makes a POST request to the specified endpoint
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Makes a PUT request to the specified endpoint
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Makes a DELETE request to the specified endpoint
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Uploads a file to the specified endpoint
  Future<Response<T>> uploadFile<T>(
    String path,
    String filePath, {
    String fieldName = 'file',
    Map<String, dynamic>? formData,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final formDataMap = formData ?? {};
      formDataMap[fieldName] = await MultipartFile.fromFile(filePath);

      return await _dio.post<T>(
        path,
        data: FormData.fromMap(formDataMap),
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Handles Dio errors and converts them to more specific exceptions
  Exception _handleDioError(DioException error) {
    if (error.response != null) {
      // Handle server errors with response
      final response = error.response!;
      switch (response.statusCode) {
        case 400:
          return BadRequestException(response);
        case 401:
          return UnauthorizedException(response);
        case 403:
          return ForbiddenException(response);
        case 404:
          return NotFoundException(response);
        case 500:
          return ServerErrorException(response);
        default:
          return ApiException(response);
      }
    } else {
      // Handle network/dio specific errors
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return NetworkException(error);
        case DioExceptionType.badCertificate:
          return BadCertificateException(error);
        case DioExceptionType.badResponse:
          return BadResponseException(error);
        case DioExceptionType.cancel:
          return RequestCancelledException(error);
        case DioExceptionType.connectionError:
          return ConnectionErrorException(error);
        case DioExceptionType.unknown:
          return UnknownNetworkException(error);
      }
    }
  }
}

/// Interceptor for adding authentication token to requests
class _AuthInterceptor extends Interceptor {
  final SharedPreferences _prefs;

  _AuthInterceptor(this._prefs);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _prefs.getString(ApiService._tokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = token;
    }
    handler.next(options);
  }
}

/// Interceptor for logging requests and responses (debug only)
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('''
🚀 REQUEST: ${options.method} ${options.uri}
📋 Headers: ${options.headers}
📦 Data: ${options.data}
''');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('''
✅ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}
📦 Data: ${response.data}
''');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('''
❌ ERROR: ${err.requestOptions.method} ${err.requestOptions.uri}
🔍 Type: ${err.type}
💬 Message: ${err.message}
📊 Status: ${err.response?.statusCode}
📦 Data: ${err.response?.data}
''');
    handler.next(err);
  }
}

/// Interceptor for handling token expiration (401 responses)
class _ErrorHandlingInterceptor extends Interceptor {
  final SharedPreferences _prefs;

  _ErrorHandlingInterceptor(this._prefs);

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await _prefs.remove(ApiService._tokenKey);
      // You might want to add navigation logic here
    }
    handler.next(err);
  }
}

/// Interceptor for retrying failed requests
class _RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final List<Duration> retryDelays;

  _RetryInterceptor(
    this.dio, {
    this.maxRetries = 3,
    this.retryDelays = const [
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 3),
    ],
  });

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    var extra = err.requestOptions.extra;

    if (extra['noRetry'] == true) {
      return handler.next(err);
    }

    var retriesCount = extra['retriesCount'] ?? 0;

    if (retriesCount < maxRetries && _shouldRetry(err)) {
      retriesCount++;
      extra['retriesCount'] = retriesCount;

      final delay = retriesCount <= retryDelays.length
          ? retryDelays[retriesCount - 1]
          : retryDelays.last;

      debugPrint(
          '🔄 Retry attempt $retriesCount for ${err.requestOptions.path} after $delay');

      await Future.delayed(delay);

      try {
        final response = await dio.request(
          err.requestOptions.path,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
            extra: extra,
          ),
        );
        return handler.resolve(response);
      } catch (e) {
        return handler.next(err);
      }
    }

    return handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        (err.type == DioExceptionType.unknown &&
            err.error is SocketException) ||
        (err.response?.statusCode != null && err.response!.statusCode! >= 500);
  }
}

/// Custom exceptions for API errors
class ApiException implements Exception {
  final Response response;

  ApiException(this.response);

  String get message => response.statusMessage ?? 'Unknown API error';
  int get statusCode => response.statusCode ?? -1;

  @override
  String toString() => 'API Exception: $statusCode - $message';
}

class BadRequestException extends ApiException {
  BadRequestException(super.response);

  @override
  String get message => 'Invalid request: ${response.data?['message']}';
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.response);

  @override
  String get message => 'Authentication required';
}

class ForbiddenException extends ApiException {
  ForbiddenException(super.response);

  @override
  String get message => 'Access denied';
}

class NotFoundException extends ApiException {
  NotFoundException(super.response);

  @override
  String get message => 'Resource not found';
}

class ServerErrorException extends ApiException {
  ServerErrorException(super.response);

  @override
  String get message => 'Server error occurred';
}

/// Network-related exceptions
class NetworkException implements Exception {
  final DioException error;

  NetworkException(this.error);

  String get message => error.message ?? 'Network error occurred';

  @override
  String toString() => 'Network Exception: $message';
}

class BadCertificateException extends NetworkException {
  BadCertificateException(super.error);

  @override
  String get message => 'Invalid SSL certificate';
}

class BadResponseException extends NetworkException {
  BadResponseException(super.error);

  @override
  String get message => 'Invalid server response';
}

class RequestCancelledException extends NetworkException {
  RequestCancelledException(super.error);

  @override
  String get message => 'Request was cancelled';
}

class ConnectionErrorException extends NetworkException {
  ConnectionErrorException(super.error);

  @override
  String get message => 'Connection error occurred';
}

class UnknownNetworkException extends NetworkException {
  UnknownNetworkException(super.error);

  @override
  String get message => 'Unknown network error occurred';
}
