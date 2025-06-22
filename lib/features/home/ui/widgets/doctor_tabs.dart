import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorTabBar extends StatelessWidget {
  final TabController tabController;

  const DoctorTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: false,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: const Color(0xFF0066FF),
      indicatorWeight: 2,
      labelColor: const Color(0xFF0066FF),
      unselectedLabelColor: Colors.grey,
      labelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      tabs: const [
        Tab(text: 'About'),
        Tab(text: 'Location'),
        Tab(text: 'Reviews'),
      ],
    );
  }
}
