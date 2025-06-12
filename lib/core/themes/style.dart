import 'package:advanced_app/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static TextStyle font24Black780Weight = const TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static TextStyle font32BlueBold = const TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static TextStyle font13GrayRegular = const TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textgrey,
  );
  
  static TextStyle font14BlackRegular = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textblack,
  );

  static TextStyle font16WhiteSemiBold = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textgrey,
  );

  static TextStyle font18WhiteSemiBold = TextStyle(
      color: Colors.white, fontSize: 18.0.sp, fontWeight: FontWeight.bold);
}
