import 'package:dio/dio.dart';

import '../../../../core/networking/api_service.dart';
import '../../../../core/networking/endpoint.dart';
import '../../../../core/networking/main_resp.dart';
import '../models/doc_model.dart';

class DoctorRepository {
  final ApiService apiService;
  DoctorRepository(this.apiService);

  Future<BaseResponse<List<DoctorModel>>> getAllDoctors() async {
    try {
      final response = await apiService.get(EndPoints.getAllDoctors);

      if (response.data == null) {
        throw const DoctorException('No data received from server');
      }

      final baseResponse = BaseResponse<List<DoctorModel>>.fromNestedJson(
        response.data,
        'doctors', // The key where the doctors array is located
        (items) => items is List
            ? items
                .map<DoctorModel>((item) => DoctorModel.fromJson(item))
                .toList()
            : <DoctorModel>[],
      );

      return baseResponse;
    } on DioException catch (e) {
      throw DoctorException(
        e.response?.data?['message'] ?? 'Failed to fetch doctors.',
      );
    } catch (e) {
      throw DoctorException('An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<BaseResponse<List<DoctorModel>>> getAllDoctorsbyspecialit(
      String Specialty) async {
    try {
      final response = await apiService
          .get("${EndPoints.getAllDoctorsbyspecialit}/$Specialty");

      if (response.data == null) {
        throw const DoctorException('No data received from server');
      }

      final baseResponse = BaseResponse<List<DoctorModel>>.fromNestedJson(
        response.data,
        'doctors', // The key where the doctors array is located
        (items) => items is List
            ? items
                .map<DoctorModel>((item) => DoctorModel.fromJson(item))
                .toList()
            : <DoctorModel>[],
      );

      return baseResponse;
    } on DioException catch (e) {
      throw DoctorException(
        e.response?.data?['message'] ?? 'Failed to fetch doctors.',
      );
    } catch (e) {
      throw DoctorException('An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<BaseResponse<dynamic>> addReview({
    required int doctorId,
    required double rating,
    required String reviewText,
    required String reviewerName,
    String? reviewerImage,
  }) async {
    try {
      final response = await apiService.post(
        EndPoints.addReview,
        data: {
          "DoctorID": doctorId,
          "ReviewerName": reviewerName,
          "Rating": rating,
          "ReviewText": reviewText,
          "ReviewerImage": reviewerImage
        },
      );

      if (response.data == null) {
        throw const DoctorException('No response from server');
      }

      return BaseResponse.fromJson(response.data, (data) => data);
    } on DioException catch (e) {
      throw DoctorException(
          e.response?.data?['message'] ?? 'Failed to add review.');
    } catch (e) {
      throw DoctorException('An unexpected error occurred: ${e.toString()}');
    }
  }
}

class DoctorException implements Exception {
  final String message;
  const DoctorException(this.message);

  @override
  String toString() => 'DoctorException: $message';
}
