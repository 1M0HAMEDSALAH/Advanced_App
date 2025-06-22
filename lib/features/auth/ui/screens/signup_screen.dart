import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/networking/api_service.dart';
import '../../data/repo/auth_repo.dart';
import '../../logic/auth_bloc.dart';
import '../widgets/login_header.dart';
import '../widgets/signup_content.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        // Create a new AuthBloc instance
        create: (context) => AuthBloc(
          authRepository: AuthRepository(
            ApiService(), // Make sure ApiService is properly initialized
          ),
        ),
        child: const _SignUpScreenContent(),
      ),
    );
  }
}

class _SignUpScreenContent extends StatelessWidget {
  const _SignUpScreenContent();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoginHeader(
              title: "Create Account",
              subtitle:
                  "Sign up now and start exploring all that our app has to offer. "
                  "We're excited to welcome you to our community!",
            ),
            SignupContent(),
          ],
        ),
      ),
    );
  }
}
