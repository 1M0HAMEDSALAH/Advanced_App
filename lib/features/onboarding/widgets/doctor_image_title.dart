import 'package:advanced_app/core/themes/image.dart';
import 'package:flutter/material.dart';
import '../../../core/themes/style.dart';

class DoctorImageAndTitle extends StatelessWidget {
  const DoctorImageAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(AppImages.background),
        Container(
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.14, 0.4],
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0.0),
                ],
              ),
            ),
            child: Image.asset(AppImages.doctorImage)),
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Text(
                'Best Doctor \nAppointment App',
                textAlign: TextAlign.center,
                style: TextStyles.font32BlueBold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
