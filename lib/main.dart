import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weight_tracker/core/di/dependency_injection.dart';
import 'package:weight_tracker/core/routing/app_router.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/weight_tracker_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

  if (supabaseUrl == null || supabaseUrl.isEmpty) {
    throw StateError('Missing SUPABASE_URL in .env file.');
  }

  if (supabaseAnonKey == null || supabaseAnonKey.isEmpty) {
    throw StateError('Missing SUPABASE_ANON_KEY in .env file.');
  }

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  await setupDependencyInjection();

  final currentUser = Supabase.instance.client.auth.currentUser;
  final initialRoute =
      currentUser != null ? Routes.dashboardScreen : Routes.onboardingScreen;

  runApp(
    WeightTrackerApp(
      appRouter: AppRouter(),
      initialRoute: initialRoute,
    ),
  );
}
