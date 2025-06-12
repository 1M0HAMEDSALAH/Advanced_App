import 'package:advanced_app/core/themes/color.dart';
import 'package:flutter/material.dart';

import '../../../core/themes/style.dart';


class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          minimumSize: const Size(double.infinity, 55.0),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        ),
        child: Text(
          text,
          style: TextStyles.font18WhiteSemiBold,
        ),
      ),
    );
  }
}
