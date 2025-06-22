import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/networking/api_service.dart';
import '../../data/repo/doc_repo.dart';

class DoctorsListScreen extends StatelessWidget {
  final String specialty;

  const DoctorsListScreen({
    super.key,
    required this.specialty,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$specialty Doctors'),
        elevation: 0,
      ),
      body: FutureBuilder(
        future:
            DoctorRepository(ApiService()).getAllDoctorsbyspecialit(specialty),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final doctors = snapshot.data?.data ?? [];

          if (doctors.isEmpty) {
            return Center(
              child: Text(
                'No doctors found for $specialty',
                style: TextStyle(fontSize: 16.sp),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              return Card(
                margin: EdgeInsets.only(bottom: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.w),
                  leading: CircleAvatar(
                    radius: 25.r,
                    // backgroundImage: NetworkImage(doctor.avatarUrl ?? ''),
                  ),
                  title: Text(
                    doctor.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    doctor.specialization,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
