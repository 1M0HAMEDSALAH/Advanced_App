import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/doctor_bloc.dart';
import '../../screens/all_doctors_screen.dart';
import 'doctor_list.dart';
import 'section_header.dart';

class DoctorRecommendationSection extends StatelessWidget {
  final VoidCallback onRefresh;

  const DoctorRecommendationSection({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorBloc, DoctorState>(
      builder: (context, state) {
        if (state is DoctorLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DoctorError) {
          return Center(child: Text(state.message));
        } else if (state is DoctorLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: "Recommendation Doctor",
                onSeeAllTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AllDoctorsScreen(doctors: state.doctors),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              DoctorList(
                doctors: state.doctors.take(3).toList(),
                onRefresh: onRefresh,
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
