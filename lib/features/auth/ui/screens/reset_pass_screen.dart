import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../onboarding/widgets/custom_button.dart';
import '../widgets/customtextform.dart';
import '../widgets/login_header.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _resetPasswordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LoginHeader(
              title: "Reset Your Password",
              subtitle: "Create a new password to secure your account.",
            ),
            SizedBox(height: 20.sp),
            CustomTextFormField(
              controller: _resetPasswordController,
              hintText: 'Enter New Password',
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              hintText: 'Confirm Password',
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _resetPasswordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 24.0),
            Spacer(),
            CustomButton(
              onPressed: () {
                if (_resetPasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please enter your New Password')),
                  );
                  return;
                }
                // Here you would typically call a method to handle the password reset
                // context.pushNamed(Routes.restpasswordscreen);
              },
              text: 'Confirm Password',
            ),
            SizedBox(height: 50.sp),
          ],
        ),
      ),
    );
  }
}
