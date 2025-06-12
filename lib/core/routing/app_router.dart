import 'package:advanced_app/core/routing/routes.dart';
import 'package:advanced_app/features/auth/ui/screens/forget_password_screen.dart';
import 'package:advanced_app/features/home/ui/screens/home_screen.dart';
import 'package:advanced_app/features/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import '../../features/auth/ui/screens/login_screen.dart';
import '../../features/auth/ui/screens/reset_pass_screen.dart';
import '../../features/auth/ui/screens/signup_screen.dart';
import '../../features/navigation/navigation_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.homescreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case Routes.forgetpasswordscreen:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case Routes.restpasswordscreen:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case Routes.navigationScreen:
        return MaterialPageRoute(builder: (_) => const NavigationScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text("No route defined for ${setting.name}"),
                  ),
                ));
    }
  }
}
