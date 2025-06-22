import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/networking/endpoint.dart';
import '../../data/models/doc_model.dart';

class DoctorProfileImage extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorProfileImage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.network(
          "${EndPoints.baseUrlImages}$doctor",
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.person,
            size: 40.sp,
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
