import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class UploadProfileImage extends ProfileEvent {
  final File image;
  final int userId;

  const UploadProfileImage({required this.image, required this.userId});

  @override
  List<Object?> get props => [image, userId];
}
