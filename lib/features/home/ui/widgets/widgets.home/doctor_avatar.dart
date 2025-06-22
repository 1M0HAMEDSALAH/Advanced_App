import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/themes/image.dart';

class DoctorAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.sp),
      child: Image.asset(
        AppImages.doctorImageList,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
    );
  }
}
