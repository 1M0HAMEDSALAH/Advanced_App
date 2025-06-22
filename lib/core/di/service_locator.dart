// In your dependency injection file (usually di.dart or setup_locator.dart)
import 'package:advanced_app/core/networking/api_service.dart';
import 'package:advanced_app/features/home/data/repo/doc_repo.dart';
import 'package:advanced_app/features/inbox/data/repositories/chat_repository.dart';
import 'package:advanced_app/features/inbox/presentation/bloc/chat_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/account/data/repositories/profile_repository.dart';
import '../../features/account/presentation/bloc/profile_bloc.dart';
import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/logic/auth_bloc.dart';
import '../../features/home/logic/doctor_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Setup API Service

  final apiService = ApiService();
  await apiService.initialize();
  getIt.registerSingleton<ApiService>(apiService);

  // Setup Repositories
  getIt.registerSingleton<AuthRepository>(
    AuthRepository(
      getIt<ApiService>(),
    ),
  );

  getIt.registerSingleton<DoctorRepository>(
    DoctorRepository(getIt<ApiService>()),
  );

  getIt.registerSingleton<ProfileRepository>(
    ProfileRepository(getIt<ApiService>()),
  );

  getIt.registerSingleton<ChatRepository>(
    ChatRepository(getIt<ApiService>()),
  );

  // Setup BLoCs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: getIt<AuthRepository>()),
  );

  getIt.registerFactory<DoctorBloc>(
    () => DoctorBloc(getIt<DoctorRepository>()),
  );

  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(getIt<ProfileRepository>()),
  );

  getIt.registerFactory<ChatBloc>(
    () => ChatBloc(getIt<ChatRepository>()),
  );
}
