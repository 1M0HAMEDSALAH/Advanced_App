import 'package:advanced_app/core/di/service_locator.dart';
import 'package:advanced_app/core/routing/app_router.dart';
import 'package:advanced_app/core/routing/routes.dart';
import 'package:advanced_app/features/account/data/repositories/profile_repository.dart';
import 'package:advanced_app/features/account/presentation/bloc/profile_bloc.dart';
import 'package:advanced_app/features/auth/data/repo/auth_repo.dart';
import 'package:advanced_app/features/auth/logic/auth_bloc.dart';
import 'package:advanced_app/features/home/data/repo/doc_repo.dart';
import 'package:advanced_app/features/inbox/data/repositories/chat_repository.dart';
import 'package:advanced_app/features/inbox/presentation/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/themes/app_theme.dart';
import 'features/home/logic/doctor_bloc.dart';
import 'features/navigation/bloc/navigation_bloc.dart';

class MyApp extends StatefulWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _initialRoute = Routes.onBoardingScreen;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Check if user has all required authentication data
      final token = prefs.getString('userToken');
      final partyId =
          prefs.getString('PartyId'); // or getInt if it's stored as int
      final userId =
          prefs.getString('UserId'); // or getInt if it's stored as int

      // If all authentication data exists, user is logged in
      if (token != null &&
          token.isNotEmpty &&
          partyId != null &&
          partyId.isNotEmpty &&
          userId != null &&
          userId.isNotEmpty) {
        // Optional: Validate token expiry if you store it
        // final tokenExpiry = prefs.getString('token_expiry');
        // if (tokenExpiry != null) {
        //   final expiryDate = DateTime.parse(tokenExpiry);
        //   if (DateTime.now().isAfter(expiryDate)) {
        //     // Token expired, clear cache and go to login
        //     await _clearAuthCache();
        //     _initialRoute = Routes.loginScreen;
        //   } else {
        //     _initialRoute = Routes.navigationScreen;
        //   }
        // } else {
        //   _initialRoute = Routes.navigationScreen;
        // }

        _initialRoute = Routes.navigationScreen;
      } else {
        // Check if user has seen onboarding
        final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;
        _initialRoute =
            hasSeenOnboarding ? Routes.loginScreen : Routes.onBoardingScreen;
      }
    } catch (e) {
      // In case of any error, default to onboarding
      _initialRoute = Routes.onBoardingScreen;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _clearAuthCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('party_id');
    await prefs.remove('user_id');
    // Remove any other auth-related data you might have stored
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return MaterialApp(
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        theme: theme(),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (_) => NavigationBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            authRepository: getIt<AuthRepository>(),
          ),
        ),
        BlocProvider<DoctorBloc>(
          create: (_) => DoctorBloc(
            getIt<DoctorRepository>(),
          ),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(
            getIt<ProfileRepository>(),
          ),
        ),
        BlocProvider<ChatBloc>(
          create: (_) => ChatBloc(
            getIt<ChatRepository>(),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: widget.appRouter.generateRoute,
            initialRoute: _initialRoute,
            theme: theme(),
          );
        },
      ),
    );
  }
}
