import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/doc_model.dart';
import 'section_content.dart';
import 'section_title.dart';

class DoctorAboutTab extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorAboutTab({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: 'About me', isLarge: true),
          SizedBox(height: 12.h),
          SectionContent(content: doctor.about),
          SizedBox(height: 24.h),
          SectionTitle(title: 'Working Time'),
          SizedBox(height: 8.h),
          SectionContent(content: doctor.workingTime),
          SizedBox(height: 24.h),
          SectionTitle(title: 'STR'),
          SizedBox(height: 8.h),
          SectionContent(content: doctor.strNumber),
          SizedBox(height: 24.h),
          SectionTitle(title: 'Pengalaman Praktik'),
          SizedBox(height: 8.h),
          SectionContent(content: doctor.practicePlace),
          SizedBox(height: 4.h),
          Text(
            '2017 - sekarang',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
