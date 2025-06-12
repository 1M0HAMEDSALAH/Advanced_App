import 'package:flutter/material.dart';
import '../../../../../../../core/themes/color.dart';
import '../../../../../../../core/themes/style.dart';

class LoginOptions extends StatelessWidget {
  const LoginOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              const Expanded(
                child: Divider(
                  color: AppColors.textgrey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Or sign in with",
                  style: TextStyles.font13GrayRegular,
                ),
              ),
              const Expanded(
                child: Divider(
                  color: AppColors.textgrey,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Image.asset(
                  'assets/images/google.png',
                  width: 46,
                  height: 46,
                ),
                onPressed: () => _handleSocialLogin('Google'),
              ),
              IconButton(
                icon: Image.asset(
                  'assets/images/facebook.png',
                  width: 46,
                  height: 46,
                ),
                onPressed: () => _handleSocialLogin('Facebook'),
              ),
              IconButton(
                icon: Image.asset(
                  'assets/images/apple.png',
                  width: 46,
                  height: 46,
                ),
                onPressed: () => _handleSocialLogin('Apple'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleSocialLogin(String platform) {
    print('$platform login pressed');
    // Implement actual social login logic here
  }
}
