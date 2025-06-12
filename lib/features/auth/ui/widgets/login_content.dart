import 'package:advanced_app/core/helpers/extentions.dart';
import 'package:advanced_app/features/auth/ui/widgets/customtextform.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/themes/style.dart';
import '../../../../core/routing/routes.dart';
import '../../../onboarding/widgets/custom_button.dart';

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
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: _emailController,
              hintText: 'email',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!value.contains('@')) {
                  return 'Enter a valid email';
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
                  // Handle login logic here
                  print('Email: ${_emailController.text}');
                  print('Password: ${_passwordController.text}');
                  context.pushNamed(Routes.navigationScreen);
                }
              },
              text: 'Login',
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                      print('Remember me: $_rememberMe');
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
    );
  }
}
