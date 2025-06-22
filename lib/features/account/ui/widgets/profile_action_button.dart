import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/style.dart';

class ProfileActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isPrimary;

  const ProfileActionButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: isPrimary ? Colors.blue.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: isPrimary
              ? Border.all(color: Colors.blue.shade200, width: 1.5)
              : null,
          boxShadow: [
            BoxShadow(
              color: isPrimary
                  ? Colors.blue.withOpacity(0.1)
                  : Colors.black.withOpacity(0.03),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyles.font14BlackRegular.copyWith(
            color: isPrimary ? Colors.blue.shade700 : Colors.grey.shade700,
            fontWeight: isPrimary ? FontWeight.w600 : FontWeight.w500,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }
}
