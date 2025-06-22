import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/style.dart';
import '../../data/models/user_data.dart';
import '../../presentation/bloc/profile_state.dart';
import 'profile_avatar.dart';

class ProfileHeader extends StatelessWidget {
  final UserData userData;
  final ProfileState state;
  final VoidCallback onImageTap;

  const ProfileHeader({
    super.key,
    required this.userData,
    required this.state,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blueAccent.shade400,
            Colors.blueAccent.shade700,
          ],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(
            MediaQuery.of(context).size.width,
            100.0,
          ),
        ),
      ),
      padding: EdgeInsets.only(top: 40.h, bottom: 80.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Profile",
                  style: TextStyles.font24Black780Weight
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          ProfileAvatar(
            imageCache: userData.imageCache,
            state: state,
            onImageTap: onImageTap,
          ),
          SizedBox(height: 16.h),
          Text(
            userData.username,
            style: TextStyles.font24Black780Weight.copyWith(
              color: Colors.white,
              fontSize: 26.sp,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            userData.email,
            style: TextStyles.font14BlackRegular.copyWith(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
