import 'package:flutter/material.dart';

import '../../data/models/doc_model.dart';
import 'doctor_about_tab.dart';
import 'doctor_location_tab.dart';
import 'doctor_reviews_tab.dart';

class DoctorTabBarView extends StatelessWidget {
  final TabController tabController;
  final DoctorModel doctor;

  const DoctorTabBarView({
    super.key,
    required this.tabController,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: [
          DoctorAboutTab(doctor: doctor),
          DoctorLocationTab(doctor: doctor),
          DoctorReviewsTab(doctor: doctor),
        ],
      ),
    );
  }
}
