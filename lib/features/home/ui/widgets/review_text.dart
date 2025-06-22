import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewText extends StatelessWidget {
  final String review;

  const ReviewText({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Text(
      review,
      style: TextStyle(
        fontSize: 14.sp,
        color: Colors.grey[700],
        height: 1.4,
      ),
    );
  }
}
