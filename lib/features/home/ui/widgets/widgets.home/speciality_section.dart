import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screens/all_specialties_screen.dart';
import 'speciality_item.dart';

class SpecialitySection extends StatelessWidget {
  final List<Map<String, dynamic>> specialties = const [
    {"icon": Icons.medical_services, "label": "General"},
    {"icon": Icons.psychology, "label": "Neurologic"},
    {"icon": Icons.child_care, "label": "Pediatric"},
    {"icon": Icons.radio, "label": "Radiology"},
    {"icon": Icons.favorite, "label": "Cardiology"},
    {"icon": Icons.dehaze, "label": "Dental"},
    {"icon": Icons.remove_red_eye, "label": "Eye Care"},
    {"icon": Icons.wheelchair_pickup, "label": "Orthopedic"},
    {"icon": Icons.face_retouching_natural, "label": "Dermatology"},
    {"icon": Icons.hearing, "label": "ENT"},
  ];

  const SpecialitySection({super.key});

  void _handleSpecialityTap(String specialty) {
    debugPrint('Selected specialty: $specialty');
    // TODO: Navigate to specialty details or filtered doctors
  }

  Future<void> _handleSeeAll(BuildContext context) async {
    final selectedSpecialty = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const AllSpecialtiesScreen()),
    );

    if (selectedSpecialty != null) {
      _handleSpecialityTap(selectedSpecialty);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Doctor Speciality",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: () => _handleSeeAll(context),
                child: const Text(
                  "See All",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 115.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemCount: specialties.length,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              final specialty = specialties[index];
              return SpecialityItem(
                icon: specialty["icon"] as IconData,
                label: specialty["label"]!,
                onTap: () => _handleSpecialityTap(specialty["label"]!),
              );
            },
          ),
        ),
      ],
    );
  }
}
