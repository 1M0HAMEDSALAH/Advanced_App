import 'package:flutter/material.dart';

import 'doctor_rating.dart';

class DoctorInfo extends StatelessWidget {
  final dynamic doctor; // Replace with your Doctor model type

  const DoctorInfo({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          doctor.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "${doctor.specialization}  |  ${doctor.practicePlace}",
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 6),
        DoctorRating(
          rating: doctor.rating,
          reviewCount: doctor.reviewCount,
        ),
      ],
    );
  }
}
