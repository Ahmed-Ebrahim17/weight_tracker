import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/core/di/dependency_injection.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:weight_tracker/features/auth/presentation/screens/home_screen.dart';
import 'package:weight_tracker/features/auth/presentation/screens/login_screen.dart';
import 'package:weight_tracker/features/auth/presentation/screens/register_screen.dart';
import 'package:weight_tracker/features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
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
        case Routes.homeScreen:
        return MaterialPageRoute( builder: (context) => HomeScreen());    
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No route defined for ${settings.name}")),
          ),
        );
    }
  }
}
