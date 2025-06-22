import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'profile_action_button.dart';

class ProfileActionButtons extends StatelessWidget {
  final VoidCallback onMyAppointmentTap;
  final VoidCallback onMedicalRecordsTap;

  const ProfileActionButtons({
    super.key,
    required this.onMyAppointmentTap,
    required this.onMedicalRecordsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: ProfileActionButton(
              title: "My Appointment",
              onTap: onMyAppointmentTap,
              isPrimary: true,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ProfileActionButton(
              title: "Medical records",
              onTap: onMedicalRecordsTap,
              isPrimary: false,
            ),
          ),
        ],
      ),
    );
  }
}
