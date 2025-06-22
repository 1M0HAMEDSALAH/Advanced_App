import 'package:advanced_app/core/networking/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewerAvatar extends StatelessWidget {
  final String profileImageUrl;

  const ReviewerAvatar({super.key, required this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: Colors.grey[300],
      child: profileImageUrl.isNotEmpty
          ? CircleAvatar(
              radius: 18.r,
              backgroundImage:
                  NetworkImage("${EndPoints.baseUrlImages}$profileImageUrl"),
              onBackgroundImageError: (exception, stackTrace) {
                debugPrint('Error loading reviewer profile image: $exception');
              },
            )
          : CircleAvatar(
              radius: 18.r,
              child: Icon(Icons.person, size: 20.sp, color: Colors.grey[600]),
            ),
    );
  }
}
