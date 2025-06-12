import 'package:flutter/material.dart';
import '../../../../../../../core/helpers/extentions.dart';
import '../../../../../../../core/routing/routes.dart';
import '../../../../../../../core/themes/style.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyles.font14BlackRegular.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {
              context.pushNamed(Routes.signUpScreen);
            },
            child: Text(
              "Sign Up",
              style: TextStyles.font14BlackRegular.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
