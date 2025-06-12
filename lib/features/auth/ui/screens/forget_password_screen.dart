import 'package:advanced_app/core/helpers/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/routes.dart';
import '../../../onboarding/widgets/custom_button.dart';
import '../widgets/customtextform.dart';
import '../widgets/login_header.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _emailOrphoneController = TextEditingController();
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LoginHeader(
            title: "Forgot Password",
            subtitle:
                "At our app, we take the security of your information seriously.",
          ),
          
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: _emailOrphoneController,
            hintText: 'email Or phone Or name',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'emailOrphone is required';
              }
              return null;
            },
          ),
          Spacer(),
          CustomButton(
            onPressed: () {
              if (_emailOrphoneController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter your email or phone')),
                );
                return;
              }
              // Here you would typically call a method to handle the password reset
              context.pushNamed(Routes.restpasswordscreen);
            },
            text: 'Reset Password',
          ),
          SizedBox(height: 50.sp),
        ],
      )),
    );
  }
}
