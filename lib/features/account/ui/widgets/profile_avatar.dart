import 'package:flutter/material.dart';

import '../../../../core/networking/endpoint.dart';
import '../../../../core/themes/image.dart';
import '../../presentation/bloc/profile_state.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageCache;
  final ProfileState state;
  final VoidCallback onImageTap;

  const ProfileAvatar({
    super.key,
    required this.imageCache,
    required this.state,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 58,
              backgroundImage: imageCache.isNotEmpty
                  ? NetworkImage("${EndPoints.baseUrlImages}$imageCache")
                  : const AssetImage(AppImages.defaultProfile) as ImageProvider,
            ),
          ),
          if (state is ProfileImageUploading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: state is ProfileImageUploading ? null : onImageTap,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: state is ProfileImageUploading
                      ? Colors.grey
                      : Colors.blue,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
