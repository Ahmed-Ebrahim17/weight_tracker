import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/core/di/dependency_injection.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:weight_tracker/features/auth/presentation/screens/login_screen.dart';
import 'package:weight_tracker/features/auth/presentation/screens/register_screen.dart';
import 'package:weight_tracker/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/dashboard_screen.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/entry_edit_screen.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/goal_screen.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/history_screen.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/log_weight_section.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboardingScreen:
        if (getIt.isRegistered<AuthCubit>()) {
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => getIt<AuthCubit>()..loadCurrentUser(),
              child: const OnboardingScreen(),
            ),
          );
        }

        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const RegisterScreen(),
          ),
        );
      case Routes.dashboardScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<AuthCubit>()..loadCurrentUser(),
            child: BlocProvider(
              create: (context) =>
                  getIt<WeightTrackingCubit>()..loadDashboardData(),
              child: const DashboardScreen(),
            ),
          ),
        );
      case Routes.addWeightScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<WeightTrackingCubit>(),
            child: const LogWeightSection(),
          ),
        );
      case Routes.historyScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: BlocProvider(
              create: (context) =>
                  getIt<WeightTrackingCubit>()..loadDashboardData(),
              child: const HistoryScreen(),
            ),
          ),
        );
      case Routes.goalScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt<WeightTrackingCubit>()..loadDashboardData(),
            child: const GoalScreen(),
          ),
        );
      case Routes.entryEditScreen:
        final entry = settings.arguments as WeightEntryEntity;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<WeightTrackingCubit>(),
            child: EntryEditScreen(entry: entry),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No route defined for ${settings.name}")),
          ),
        );
    }
  }
}
