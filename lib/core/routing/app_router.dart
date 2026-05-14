import 'package:flutter/material.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/features/auth/presentation/screens/login_screen.dart';
import 'package:weight_tracker/features/auth/presentation/screens/register_screen.dart';
import 'package:weight_tracker/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/dashboard_screen.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/entry_edit_screen.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/goal_screen.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/history_screen.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/main_screen.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/seven_days_trend_screen.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/log_weight_section.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case Routes.mainScreen:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
        );
      case Routes.dashboardScreen:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );
      case Routes.addWeightScreen:
        return MaterialPageRoute(
          builder: (_) => const LogWeightSection(),
        );
      case Routes.historyScreen:
        return MaterialPageRoute(
          builder: (_) => const HistoryScreen(),
        );
      case Routes.goalScreen:
        return MaterialPageRoute(
          builder: (_) => const GoalScreen(),
        );
      case Routes.entryEditScreen:
        final entry = settings.arguments as WeightEntryEntity;
        return MaterialPageRoute(
          builder: (_) => EntryEditScreen(entry: entry),
        );
      case Routes.sevenDaysTrend:
        return MaterialPageRoute(
          builder: (_) => const SevenDaysTrendScreen(),
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
