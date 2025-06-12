import 'package:advanced_app/core/helpers/extentions.dart';
import 'package:advanced_app/features/auth/ui/widgets/customtextform.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/themes/style.dart';
import '../../../../core/routing/routes.dart';
import '../../../onboarding/widgets/custom_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class SignupContent extends StatefulWidget {
  const SignupContent({super.key});

  @override
  State<SignupContent> createState() => _SignupContentState();
}

class _SignupContentState extends State<SignupContent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _termsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: _nameController,
              hintText: 'Name',
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                if (value.length < 3) {
                  return 'Name must be at least 3 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
              controller: _emailController,
              hintText: 'Email',
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
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
              child: IntlPhoneField(
                controller: _phoneController,
                style: const TextStyle(
                  fontSize: 14,
                ),
                dropdownTextStyle: const TextStyle(
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: const TextStyle(
                    color: Color(0xFFC2C2C2),
                    fontSize: 14,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  filled: true,
                  fillColor: const Color(0xFFFDFDFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.red.shade400),
                  ),
                ),
                initialCountryCode: 'US',
                dropdownIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
                disableLengthCheck: true,
                onChanged: (PhoneNumber number) {
                  print(number.completeNumber);
                },
                validator: (PhoneNumber? number) {
                  if (number == null || number.number.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (number.number.length < 8) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
              controller: _passwordController,
              hintText: 'Password',
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
            const SizedBox(height: 8),
            CustomTextFormField(
              controller: _confirmPasswordController,
              hintText: 'Confirm Password',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Checkbox(
                    value: _termsAccepted,
                    onChanged: (bool? value) {
                      setState(() {
                        _termsAccepted = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyles.font13GrayRegular,
                        children: [
                          const TextSpan(text: "I agree to the "),
                          TextSpan(
                            text: "Terms & Conditions",
                            style: TextStyles.font13GrayRegular.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Show terms dialog
                              },
                          ),
                          const TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyles.font13GrayRegular.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Show privacy policy dialog
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (!_termsAccepted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please accept the terms and conditions'),
                      ),
                    );
                    return;
                  }

                  // Handle signup logic here
                  print('Name: ${_nameController.text}');
                  print('Email: ${_emailController.text}');
                  print('Phone: ${_phoneController.text}');
                  print('Password: ${_passwordController.text}');

                  // Navigate to home screen or verification screen
                  context.pushNamed(Routes.homescreen);
                }
              },
              text: 'Sign Up',
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyles.font14BlackRegular.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(Routes.loginScreen);
                    },
                    child: Text(
                      "Login",
                      style: TextStyles.font14BlackRegular.copyWith(
                        fontWeight: FontWeight.bold,
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
