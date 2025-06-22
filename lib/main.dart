import 'package:advanced_app/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'core/di/service_locator.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}
