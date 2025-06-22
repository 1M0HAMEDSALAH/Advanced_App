import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/color.dart';
import '../../../../core/themes/image.dart';

class DoctorChatIcon extends StatelessWidget {
  final VoidCallback onTap;

  const DoctorChatIcon({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        AppImages.inboxNavIcon,
        color: AppColors.primary,
        width: 24.h,
        height: 24.h,
        fit: BoxFit.cover,
      ),
    );
  }
}
