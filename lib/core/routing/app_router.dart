import 'package:flutter/material.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/features/loginScreen/ui/login_screen.dart';
import 'package:weight_tracker/features/splashScreen/ui/splash_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No route defined for ${settings.name}")),
          ),
        );
    }
  }
}
