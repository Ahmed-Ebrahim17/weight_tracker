import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/core/di/dependency_injection.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:weight_tracker/features/auth/presentation/screens/login_screen.dart';
import 'package:weight_tracker/features/auth/presentation/screens/register_screen.dart';
import 'package:weight_tracker/features/splash/presentation/screens/splash_screen.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/dashboard_screen.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/log_weight_section.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        if (getIt.isRegistered<AuthCubit>()) {
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => getIt<AuthCubit>()..loadCurrentUser(),
              child: const SplashScreen(),
            ),
          );
        }

        return MaterialPageRoute(builder: (context) => const SplashScreen());
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
          builder: (context) => MultiBlocProvider(
            // ← wraps MULTIPLE cubits
            providers: [
              BlocProvider(create: (context) => getIt<AuthCubit>()),
              BlocProvider(
                create: (context) =>
                    getIt<WeightTrackingCubit>()
                      ..loadDashboardData(), // load data immediately
              ),
            ],
            child: const DashboardScreen(),
          ),
        );
      case Routes.addWeightScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<WeightTrackingCubit>(),
            child: const LogWeightSection(),
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
