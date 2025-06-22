import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/themes/image.dart';

class NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 18.sp),
      child: CircleAvatar(
        backgroundColor: const Color(0xFFF5F5F5),
        radius: 30.sp,
        child: Image.asset(
          AppImages.notificationIcon,
          width: 24.sp,
          height: 24.sp,
        ),
      ),
    );
  }
}
