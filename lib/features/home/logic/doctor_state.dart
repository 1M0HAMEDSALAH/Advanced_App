part of 'doctor_bloc.dart';

abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorLoaded extends DoctorState {
  final List<DoctorModel> doctors;
  DoctorLoaded(this.doctors);
}

class DoctorBySpecialtyLoaded extends DoctorState {
  final List<DoctorModel> doctors;
  DoctorBySpecialtyLoaded(this.doctors);
}

class DoctorError extends DoctorState {
  final String message;
  DoctorError(this.message);
}

class DoctorReviewAdded extends DoctorState {
  final dynamic data;
  DoctorReviewAdded(this.data);
}
