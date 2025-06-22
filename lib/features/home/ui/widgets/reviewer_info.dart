import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'star_rating.dart';

class ReviewerInfo extends StatelessWidget {
  final String name;
  final int rating;
  final String time;

  const ReviewerInfo({
    super.key,
    required this.name,
    required this.rating,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            StarRating(rating: rating),
            const Spacer(),
            Text(
              time,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
