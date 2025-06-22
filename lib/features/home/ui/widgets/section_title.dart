import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final bool isLarge;

  const SectionTitle({
    super.key,
    required this.title,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: isLarge ? 18.sp : 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }
}
