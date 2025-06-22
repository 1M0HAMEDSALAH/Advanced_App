import 'package:advanced_app/core/routing/routes.dart';
import 'package:advanced_app/features/auth/ui/screens/forget_password_screen.dart';
import 'package:advanced_app/features/auth/ui/screens/login_screen.dart';
import 'package:advanced_app/features/auth/ui/screens/reset_pass_screen.dart';
import 'package:advanced_app/features/auth/ui/screens/signup_screen.dart';
import 'package:advanced_app/features/home/data/models/doc_model.dart';
import 'package:advanced_app/features/home/ui/screens/all_doctors_screen.dart';
import 'package:advanced_app/features/home/ui/screens/home_screen.dart';
import 'package:advanced_app/features/navigation/navigation_screen.dart';
import 'package:advanced_app/features/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
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
        return MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(userId: (args as int?) ?? 0),
        );

      case Routes.allDoctorsScreen:
        if (args is List<DoctorModel>) {
          return MaterialPageRoute(
              builder: (_) => AllDoctorsScreen(doctors: args));
        } else {
          return _errorRoute("Invalid arguments for allDoctorsScreen");
        }

      case Routes.navigationScreen:
        return MaterialPageRoute(builder: (_) => const NavigationScreen());

      default:
        return _errorRoute("No route defined for ${settings.name}");
    }
  }

  Route _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text(message)),
      ),
    );
  }
}
