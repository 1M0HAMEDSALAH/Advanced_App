import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/style.dart';

class ProfileBottomActions extends StatelessWidget {
  final int userId;
  final VoidCallback onChangePasswordTap;
  final VoidCallback onLogoutTap;

  const ProfileBottomActions({
    super.key,
    required this.userId,
    required this.onChangePasswordTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: onChangePasswordTap,
            icon: const Icon(Icons.lock_reset, size: 20),
            label: const Text("تغيير كلمة المرور"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade600,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 52.h),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              textStyle: TextStyles.font16WhiteSemiBold,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton.icon(
            onPressed: onLogoutTap,
            icon: const Icon(Icons.logout, size: 20),
            label: const Text("تسجيل الخروج"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent.shade400,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 52.h),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              textStyle: TextStyles.font16WhiteSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
