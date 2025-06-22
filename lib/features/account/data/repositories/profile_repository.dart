import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../core/networking/api_service.dart';
import '../../../../core/networking/endpoint.dart';

class ProfileRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);

  Future<Map<String, dynamic>> uploadProfileImage(
      File imageFile, int userId) async {
    print('File path: ${imageFile.path}');
    print('File extension: ${imageFile.path.split('.').last}');
    print('File exists: ${await imageFile.exists()}');

    // Extract only the filename from the full path
    final fileName = imageFile.path.split('/').last;
    print('Extracted filename: $fileName');

    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName, // Use extracted filename
        contentType: MediaType('image', 'jpeg'), // Explicitly set MIME type
      ),
    });

    final response = await _apiService.post(
      "/users/$userId${EndPoints.uploadProfileImage}",
      data: formData,
      // Remove Content-Type header to let Dio handle it automatically
    );

    if (response.data == null) {
      throw Exception('Failed to upload image');
    }

    return response.data; // Return the full response data
  }
}
