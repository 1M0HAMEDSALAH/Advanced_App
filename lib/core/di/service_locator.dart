import 'package:get_it/get_it.dart';
import '../../features/navigation/bloc/navigation_bloc.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Example: Register a singleton service
  locator.registerLazySingleton<NavigationBloc>(() => NavigationBloc());
}
