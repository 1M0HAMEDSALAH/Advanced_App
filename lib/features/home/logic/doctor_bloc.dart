import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/doc_model.dart';
import '../data/repo/doc_repo.dart';
part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorRepository doctorRepository;
  DoctorBloc(this.doctorRepository) : super(DoctorInitial()) {
    on<LoadDoctors>(_onLoadDoctors);
    on<LoadDoctorsBySpecialty>(_onLoadDoctorsbyspecialty);
    on<AddReviwForDoctor>(_addReviwForDoctor);
  }

  Future<void> _onLoadDoctors(
    LoadDoctors event,
    Emitter<DoctorState> emit,
  ) async {
    emit(DoctorLoading());
    try {
      final response = await doctorRepository.getAllDoctors();
      emit(DoctorLoaded(response.data));
    } on DoctorException catch (e) {
      emit(DoctorError(e.message));
    } catch (_) {
      emit(DoctorError('Failed to load doctors'));
    }
  }

  Future<void> _onLoadDoctorsbyspecialty(
    LoadDoctorsBySpecialty event,
    Emitter<DoctorState> emit,
  ) async {
    emit(DoctorLoading());
    try {
      final response =
          await doctorRepository.getAllDoctorsbyspecialit(event.specialty);
      emit(DoctorBySpecialtyLoaded(response.data));
    } on DoctorException catch (e) {
      emit(DoctorError(e.message));
    } catch (_) {
      emit(DoctorError('Failed to load doctors'));
    }
  }

  Future<void> _addReviwForDoctor(
    AddReviwForDoctor event,
    Emitter<DoctorState> emit,
  ) async {
    emit(DoctorLoading());
    try {
      final response = await doctorRepository.addReview(
          doctorId: event.doctorId,
          rating: event.rating,
          reviewText: event.reviewText,
          reviewerName: event.reviewerName,
          reviewerImage: event.reviewerImage);
      emit(DoctorReviewAdded(response.data));
    } on DoctorException catch (e) {
      emit(DoctorError(e.message));
    } catch (_) {
      emit(DoctorError('Failed to add review'));
    }
  }
}
