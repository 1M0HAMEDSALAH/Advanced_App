import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final int maxRating;

  const StarRating({
    super.key,
    required this.rating,
    this.maxRating = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(maxRating, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: index < rating ? Colors.amber : Colors.grey[400],
          size: 16.sp,
        );
      }),
    );
  }
}
