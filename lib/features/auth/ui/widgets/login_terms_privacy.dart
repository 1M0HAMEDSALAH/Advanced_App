import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../../../../../../core/themes/style.dart';

class LoginTermsPrivacy extends StatelessWidget {
  const LoginTermsPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyles.font13GrayRegular,
          children: [
            const TextSpan(
              text: "By logging in, you agree to our ",
            ),
            TextSpan(
              text: "Terms & Conditions",
              style: TextStyles.font14BlackRegular.copyWith(
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _showTermsDialog(context),
            ),
            const TextSpan(
              text: " and ",
            ),
            TextSpan(
              text: "Privacy Policy",
              style: TextStyles.font14BlackRegular.copyWith(
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _showPrivacyDialog(context),
            ),
            const TextSpan(
              text: ".",
            ),
          ],
        ),
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terms & Conditions'),
          content: const SingleChildScrollView(
            child: Text('Here are the Terms & Conditions...'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Privacy Policy'),
          content: const SingleChildScrollView(
            child: Text('Privacy Policy content...'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
