import 'package:flutter/material.dart';

import '../../screens/doc_details.dart';
import 'doctor_card.dart';

class DoctorList extends StatelessWidget {
  final List<dynamic> doctors; // Replace with your Doctor model type
  final VoidCallback onRefresh;

  const DoctorList({
    super.key,
    required this.doctors,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: DoctorCard(
            doctor: doctor,
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorDetailsTabScreen(doctor: doctor),
                ),
              );
              onRefresh();
            },
          ),
        );
      },
    );
  }
}
