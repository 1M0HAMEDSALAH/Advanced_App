import 'package:flutter/material.dart';

class DoctorRating extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const DoctorRating({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text("$rating ($reviewCount reviews)"),
      ],
    );
  }
}
