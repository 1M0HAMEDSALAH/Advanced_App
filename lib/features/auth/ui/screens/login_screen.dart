import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/networking/api_service.dart';
import '../../data/repo/auth_repo.dart';
import '../../logic/auth_bloc.dart';
import '../widgets/login_content.dart';
import '../widgets/login_footer.dart';
import '../widgets/login_header.dart';
import '../widgets/login_options.dart';
import '../widgets/login_terms_privacy.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: AuthRepository(
            ApiService(),
          ),
        ),
        child: const SafeArea(
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
      ),
    );
  }
}
