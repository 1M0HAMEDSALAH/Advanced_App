import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String doctorName;
  final VoidCallback onReviewTap;

  const DoctorDetailsAppBar({
    super.key,
    required this.doctorName,
    required this.onReviewTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        doctorName,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.reviews, color: Colors.black),
          onPressed: onReviewTap,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
