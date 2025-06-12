import 'package:advanced_app/core/themes/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/style.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi UserName',
                          style: TextStyles.font32BlueBold.copyWith(
                            color: Colors.black,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("How Are you Today?",
                            style: TextStyles.font13GrayRegular)
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 18.sp),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFFF5F5F5),
                        radius: 30.sp,
                        child: Image.asset(
                          AppImages.notificationIcon,
                          width: 24.sp,
                          height: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 140.sp,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0066FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Book and schedule with nearest doctor",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF0066FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text("Find Nearby"),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: -20,
                      child: Image.asset(
                        AppImages.backgrounddoctorImage,
                        height: 160,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Doctor Speciality",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "See All",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(width: 8.sp),
                      _buildSpeciality(AppImages.grneral, "General"),
                      SizedBox(width: 8.sp),
                      _buildSpeciality(AppImages.brain, "Neurologic"),
                      SizedBox(width: 8.sp),
                      _buildSpeciality(AppImages.kids, "Pediatric"),
                      SizedBox(width: 8.sp),
                      _buildSpeciality(AppImages.two, "Radiology"),
                      SizedBox(width: 8.sp),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommendation Doctor",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "See All",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.sp),
                              child: Image.asset(
                                AppImages.doctorImageList,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dr. Randy Wigham",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "General  |  RSUD Gatot Subroto",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.amber, size: 16),
                                      SizedBox(width: 4),
                                      Text("4.8.sp (4,279 reviews)"),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpeciality(String iconPath, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFF2F2F2),
            radius: 35,
            child: Image.asset(iconPath, width: 28.sp, height: 28.sp),
          ),
          SizedBox(height: 8.sp),
          Text(label),
        ],
      ),
    );
  }
}
