import 'package:flutter/material.dart';

import '../widgets/login_header.dart';
import '../widgets/signup_content.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoginHeader(
              title: "Create Account",
              subtitle:
                  "Sign up now and start exploring all that our app has to offer. We're excited to welcome you to our community!",
            ),
            SignupContent(),
          ],
        ),
      ),
    );
  }
}
