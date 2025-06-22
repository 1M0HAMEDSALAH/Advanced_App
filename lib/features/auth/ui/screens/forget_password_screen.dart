import 'package:advanced_app/core/helpers/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../../onboarding/widgets/custom_button.dart';
import '../../logic/auth_bloc.dart';
import '../../logic/auth_event.dart';
import '../../logic/auth_state.dart';
import '../widgets/customtextform.dart';
import '../widgets/login_header.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailOrPhoneController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is ForgetPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("User found. Please proceed.")),
              );
              // Navigate to reset screen or next step
              context.pushNamed(Routes.restpasswordscreen,
                  arguments: state.userId);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  controller: emailOrPhoneController,
                  hintText: 'Email, Phone or Username',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                const Spacer(),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;
                    return CustomButton(
                      onPressed: isLoading
                          ? () {}
                          : () {
                              final input = emailOrPhoneController.text.trim();
                              if (input.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Please enter your email, phone or username')),
                                );
                                return;
                              }
                              BlocProvider.of<AuthBloc>(context).add(
                                ForgetPasswordEvent(input: input),
                              );
                            },
                      text: isLoading ? 'Loading...' : 'Reset Password',
                    );
                  },
                ),
                SizedBox(height: 50.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
