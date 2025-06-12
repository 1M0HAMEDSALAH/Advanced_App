import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/themes/image.dart';


class LogoAndName extends StatelessWidget {
  const LogoAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.mainLogo,
          width: 38.sp,
          height: 38.sp,
        ),
        const SizedBox(width: 10),
        const Text(
          'Doc App',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
