import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/style.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: Colors.blue.shade700,
            size: 26,
          ),
          title: Text(
            title,
            style: TextStyles.font16WhiteSemiBold.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 17.sp,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.grey,
          ),
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
          minLeadingWidth: 28,
          horizontalTitleGap: 16,
        ),
        Divider(
          height: 1,
          color: Colors.grey.withOpacity(0.3),
          indent: 20.w,
          endIndent: 20.w,
        ),
      ],
    );
  }
}
