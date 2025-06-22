part of 'doctor_bloc.dart';

abstract class DoctorEvent {}

class LoadDoctors extends DoctorEvent {}

class LoadDoctorsBySpecialty extends DoctorEvent {
  final String specialty;

  LoadDoctorsBySpecialty({required this.specialty});
}

class AddReviwForDoctor extends DoctorEvent {
  final int doctorId;
  final double rating;
  final String reviewText;
  final String reviewerName;
  final String? reviewerImage;

  AddReviwForDoctor({
    required this.doctorId,
    required this.rating,
    required this.reviewText,
    required this.reviewerName,
    this.reviewerImage,
  });
}
