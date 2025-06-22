import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionContent extends StatelessWidget {
  final String content;

  const SectionContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 14.sp,
        color: Colors.grey[700],
        height: 1.5,
      ),
    );
  }
}
