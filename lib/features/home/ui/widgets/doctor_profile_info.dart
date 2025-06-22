import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/doc_model.dart';
import 'doctor_rating_row.dart';

class DoctorProfileInfo extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorProfileInfo({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dr. ${doctor.party.fullName}',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          '${doctor.specialization} | ${doctor.practicePlace}',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 8.h),
        DoctorRatingRow(doctor: doctor),
      ],
    );
  }
}
