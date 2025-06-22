import 'package:advanced_app/core/helpers/extentions.dart';
import 'package:advanced_app/features/auth/ui/widgets/customtextform.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../../../../../../core/themes/style.dart';
import '../../../../core/routing/routes.dart';
import '../../../onboarding/widgets/custom_button.dart';
import '../../logic/auth_bloc.dart';
import '../../logic/auth_event.dart';
import '../../logic/auth_state.dart';

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
  String? _gender = 'Male'; // Default gender
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
        if (state is RegistrationSuccess) {
          context.pushNamed(Routes.homescreen);
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
                controller: _nameController,
                hintText: 'Full Name',
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
              // Gender Selection
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: ['Male', 'Female']
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Gender is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Date of Birth Picker
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  controller: TextEditingController(
                    text: _selectedDate != null
                        ? '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}'
                        : '',
                  ),
                  validator: (value) {
                    if (_selectedDate == null) {
                      return 'Date of birth is required';
                    }
                    return null;
                  },
                ),
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
                  style: const TextStyle(fontSize: 14),
                  dropdownTextStyle: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: const TextStyle(
                      color: Color(0xFFC2C2C2),
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
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
                  dropdownIcon:
                      const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  disableLengthCheck: true,
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
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (!_termsAccepted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Please accept the terms and conditions'),
                            ),
                          );
                          return;
                        }

                        if (_selectedDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select date of birth'),
                            ),
                          );
                          return;
                        }

                        context.read<AuthBloc>().add(
                              RegisterEvent(
                                fullName: _nameController.text,
                                gender: _gender!,
                                dateOfBirth: _selectedDate!
                                    .toIso8601String()
                                    .split('T')[0],
                                phoneNumber: _phoneController.text,
                                email: _emailController.text,
                                username: _emailController.text
                                    .split('@')[0],
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                    text: 'Sign Up',
                  );
                },
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
      ),
    );
  }
}
