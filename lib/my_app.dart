import 'package:advanced_app/core/routing/app_router.dart';
import 'package:advanced_app/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/themes/app_theme.dart';
import 'features/navigation/bloc/navigation_bloc.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
      return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (_) => NavigationBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.generateRoute,
            initialRoute: Routes.onBoardingScreen,
            theme: theme(),
          );
        },
      ),
    );
  }
}
