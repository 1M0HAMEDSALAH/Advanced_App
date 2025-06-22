import 'package:advanced_app/core/helpers/extentions.dart';
import 'package:advanced_app/features/auth/ui/widgets/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/themes/style.dart';
import '../../../../core/routing/routes.dart';
import '../../../onboarding/widgets/custom_button.dart';
import '../../logic/auth_bloc.dart';
import '../../logic/auth_event.dart';
import '../../logic/auth_state.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is LoginSuccess) {
          Navigator.of(context).pop(); // Close loading
          context.pushNamed(Routes.navigationScreen);
        } else if (state is AuthError) {
          Navigator.of(context).pop(); // Close loading
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _emailController,
                hintText: 'username',
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'username is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: _passwordController,
                hintText: 'password',
                obscureText: true,
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
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<AuthBloc>(context).add(
                      LoginEvent(
                        username: _emailController.text.trim(),
                        password: _passwordController.text,
                      ),
                    );
                  }
                },
                text: 'Login',
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                    ),
                    Text(
                      "Remember me",
                      style: TextStyles.font13GrayRegular,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        context.pushNamed(Routes.forgetpasswordscreen);
                      },
                      child: Text(
                        "Forget Password?",
                        style: TextStyles.font13GrayRegular.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
