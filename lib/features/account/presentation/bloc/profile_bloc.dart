import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc(this._repository) : super(ProfileInitial()) {
    on<UploadProfileImage>(_onUploadProfileImage);
  }

  Future<void> _onUploadProfileImage(
    UploadProfileImage event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileImageUploading());

      final responseData =
          await _repository.uploadProfileImage(event.image, event.userId);

      final imageUrl = responseData['data']['data']['imageUrl'] as String;

      // ✅ حفظ الصورة الجديدة في SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("Image", imageUrl);

      emit(ProfileImageUploadSuccess(imageUrl: imageUrl));
    } catch (e) {
      emit(ProfileImageUploadFailure(e.toString()));
    }
  }
}
