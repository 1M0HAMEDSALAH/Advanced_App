import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/doc_model.dart';
import 'doctor_chat_icon.dart';
import 'doctor_profile_image.dart';
import 'doctor_profile_info.dart';

class DoctorProfileSection extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback onChatTap;

  const DoctorProfileSection({
    super.key,
    required this.doctor,
    required this.onChatTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          DoctorProfileImage(doctor: doctor),
          SizedBox(width: 16.w),
          Expanded(child: DoctorProfileInfo(doctor: doctor)),
          DoctorChatIcon(onTap: onChatTap),
        ],
      ),
    );
  }
}
