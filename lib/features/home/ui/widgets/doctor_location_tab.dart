import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/doc_model.dart';
import 'doctor_location_map.dart';
import 'section_content.dart';
import 'section_title.dart';

class DoctorLocationTab extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorLocationTab({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          SectionTitle(title: 'Practice Place'),
          SizedBox(height: 8.h),
          SectionContent(content: doctor.practicePlace),
          SizedBox(height: 24.h),
          SectionTitle(title: 'Location Map'),
          SizedBox(height: 12.h),
          DoctorLocationMap(locationUrl: doctor.locationMap),
        ],
      ),
    );
  }
}
