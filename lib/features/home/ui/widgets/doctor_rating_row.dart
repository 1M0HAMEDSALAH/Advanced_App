import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/doc_model.dart';

class DoctorRatingRow extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorRatingRow({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 16.sp),
        SizedBox(width: 4.w),
        Text(
          '${doctor.rating} (${doctor.reviewCount} reviews)',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
