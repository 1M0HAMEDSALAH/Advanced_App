import 'package:advanced_app/core/helpers/extentions.dart';
import 'package:advanced_app/core/routing/routes.dart';
import 'package:advanced_app/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/custom_button.dart';
import 'widgets/doctor_image_title.dart';
import 'widgets/logoAndname.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20, bottom: BorderSide.strokeAlignCenter),
          child: Column(
            children: [
              const LogoAndName(),
              SizedBox(height: 20.sp),
              const DoctorImageAndTitle(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Text(
                  'Manage and schedule all of your medical appointments easily with Docdoc to get a new experience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textgrey,
                  ),
                ),
              ),
              SizedBox(height: 50.sp),
              CustomButton(
                onPressed: () {
                  context.pushNamed(Routes.loginScreen);
                },
                text: 'Get Started',
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
