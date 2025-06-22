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

class ResetPasswordScreen extends StatelessWidget {
  final int userId;
  const ResetPasswordScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final resetPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSucsess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password reset successfully')),
            );
            context.pushNamedAndRemoveUntil(
              Routes.loginScreen,
              predicate: (Route<dynamic> route) {
                return false;
              },
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
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
                controller: resetPasswordController,
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
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != resetPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              const Spacer(),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return CustomButton(
                    onPressed: () {
                      final password = resetPasswordController.text;
                      final confirm = confirmPasswordController.text;

                      if (password.isEmpty || confirm.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill all fields')),
                        );
                        return;
                      }

                      if (password != confirm) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Passwords do not match')),
                        );
                        return;
                      }

                      context.read<AuthBloc>().add(
                            ResetPasswordEvent(
                              userId: userId.toString(),
                              newPassword: password,
                            ),
                          );
                    },
                    text: state is AuthLoading
                        ? 'Loading...'
                        : 'Confirm Password',
                  );
                },
              ),
              SizedBox(height: 50.sp),
            ],
          ),
        ),
      ),
    );
  }
}
