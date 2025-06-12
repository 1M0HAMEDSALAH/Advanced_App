import 'package:flutter/material.dart';
import '../widgets/login_content.dart';
import '../widgets/login_footer.dart';
import '../widgets/login_header.dart';
import '../widgets/login_options.dart';
import '../widgets/login_terms_privacy.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoginHeader(),
              LoginContent(),
              LoginOptions(),
              LoginTermsPrivacy(),
              LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
