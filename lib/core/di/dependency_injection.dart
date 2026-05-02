import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weight_tracker/core/database/database.dart';
import 'package:weight_tracker/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:weight_tracker/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:weight_tracker/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:weight_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:weight_tracker/features/auth/domain/usecases/email_login_usecase.dart';
import 'package:weight_tracker/features/auth/domain/usecases/email_register_usecase.dart';
import 'package:weight_tracker/features/auth/domain/usecases/get_current_user.dart';
import 'package:weight_tracker/features/auth/domain/usecases/google_login_usecase.dart';
import 'package:weight_tracker/features/auth/domain/usecases/logout_usecase.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:weight_tracker/core/database/services/weight_entry_service.dart';
import 'package:weight_tracker/features/weight_tracking/data/datasources/weight_tracking_local_datasource.dart';
import 'package:weight_tracker/features/weight_tracking/data/repositories/weight_tracking_repository_impl.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_tracking_repository.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/add_weight_entry_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/get_all_entries_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/get_latest_entry_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/get_entries_last_n_days_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/get_total_entries_count_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/update_weight_entry_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/delete_weight_entry_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/delete_all_entries_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/get_trend_last_n_days_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  if (!getIt.isRegistered<SharedPreferences>()) {
    getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  }

  if (!getIt.isRegistered<SupabaseClient>()) {
    getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);
  }

  if (!getIt.isRegistered<GoogleSignIn>()) {
    try {
      final webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'];
      final googleSignIn = GoogleSignIn.instance;
      // Initialize GoogleSignIn with Web OAuth 2.0 Client ID
      await googleSignIn.initialize(serverClientId: webClientId);
      getIt.registerSingleton<GoogleSignIn>(googleSignIn);
    } catch (e) {
      // If initialization fails, still register the instance (user can still use email login)
      getIt.registerSingleton<GoogleSignIn>(GoogleSignIn.instance);
    }
  }

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      supabaseClient: getIt<SupabaseClient>(),
      googleSignIn: getIt<GoogleSignIn>(),
    ),
  );

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () =>
        AuthLocalDataSourceImpl(sharedPreferences: getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localDataSource: getIt<AuthLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<EmailLoginUseCase>(
    () => EmailLoginUseCase(repository: getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<EmailRegisterUseCase>(
    () => EmailRegisterUseCase(repository: getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<GoogleLoginUseCase>(
    () => GoogleLoginUseCase(repository: getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(repository: getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(repository: getIt<AuthRepository>()),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      emailLoginUseCase: getIt<EmailLoginUseCase>(),
      emailRegisterUseCase: getIt<EmailRegisterUseCase>(),
      googleLoginUseCase: getIt<GoogleLoginUseCase>(),
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
    ),
  );

  if (!getIt.isRegistered<AppDatabase>()) {
    getIt.registerSingleton<AppDatabase>(AppDatabase());
  }

  // ── Weight Tracking Feature ──────────────────────────────────────────────

  getIt.registerLazySingleton<WeightEntryService>(
    () => WeightEntryService(getIt<AppDatabase>()),
  );

  getIt.registerLazySingleton<WeightTrackingLocalDataSource>(
    () => WeightTrackingLocalDataSourceImpl(
      weightEntryService: getIt<WeightEntryService>(),
    ),
  );

  getIt.registerLazySingleton<WeightTrackingRepository>(
    () => WeightTrackingRepositoryImpl(
      localDataSource: getIt<WeightTrackingLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<AddWeightEntryUseCase>(
    () => AddWeightEntryUseCase(repository: getIt<WeightTrackingRepository>()),
  );

  getIt.registerLazySingleton<GetAllEntriesUseCase>(
    () => GetAllEntriesUseCase(repository: getIt<WeightTrackingRepository>()),
  );

  getIt.registerLazySingleton<GetLatestEntryUseCase>(
    () => GetLatestEntryUseCase(repository: getIt<WeightTrackingRepository>()),
  );

  getIt.registerLazySingleton<GetEntriesLastNDaysUseCase>(
    () => GetEntriesLastNDaysUseCase(
      repository: getIt<WeightTrackingRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetTotalEntriesCountUseCase>(
    () => GetTotalEntriesCountUseCase(
      repository: getIt<WeightTrackingRepository>(),
    ),
  );

  getIt.registerLazySingleton<UpdateWeightEntryUseCase>(
    () =>
        UpdateWeightEntryUseCase(repository: getIt<WeightTrackingRepository>()),
  );

  getIt.registerLazySingleton<DeleteWeightEntryUseCase>(
    () =>
        DeleteWeightEntryUseCase(repository: getIt<WeightTrackingRepository>()),
  );

  getIt.registerLazySingleton<DeleteAllEntriesUseCase>(
    () =>
        DeleteAllEntriesUseCase(repository: getIt<WeightTrackingRepository>()),
  );

  getIt.registerLazySingleton<GetTrendLastNDaysUseCase>(
    () =>
        GetTrendLastNDaysUseCase(repository: getIt<WeightTrackingRepository>()),
  );

  getIt.registerFactory<WeightTrackingCubit>(
    () => WeightTrackingCubit(
      addWeightEntryUseCase: getIt<AddWeightEntryUseCase>(),
      getLatestEntryUseCase: getIt<GetLatestEntryUseCase>(),
      getEntriesLastNDaysUseCase: getIt<GetEntriesLastNDaysUseCase>(),
      getTotalEntriesCountUseCase: getIt<GetTotalEntriesCountUseCase>(),
      getTrendLastNDaysUseCase: getIt<GetTrendLastNDaysUseCase>(),
      updateWeightEntryUseCase: getIt<UpdateWeightEntryUseCase>(),
      deleteWeightEntryUseCase: getIt<DeleteWeightEntryUseCase>(),
    ),
  );
}
