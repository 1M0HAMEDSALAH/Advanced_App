import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'doctors_list_screen.dart';

class AllSpecialtiesScreen extends StatelessWidget {
  static const routeName = '/all-specialties';

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

  const AllSpecialtiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Specialties'),
        elevation: 0,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.85,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.w,
        ),
        itemCount: specialties.length,
        itemBuilder: (context, index) {
          final specialty = specialties[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DoctorsListScreen(specialty: specialty["label"]!),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    specialty["icon"] as IconData,
                    size: 32.w,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      specialty["label"]!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
