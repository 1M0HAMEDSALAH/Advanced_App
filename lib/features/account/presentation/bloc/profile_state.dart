import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileImageUploading extends ProfileState {}

class ProfileImageUploadSuccess extends ProfileState {
  final String imageUrl;

  const ProfileImageUploadSuccess({required this.imageUrl});
}

class ProfileImageUploadFailure extends ProfileState {
  final String error;
  const ProfileImageUploadFailure(this.error);

  @override
  List<Object?> get props => [error];
}
