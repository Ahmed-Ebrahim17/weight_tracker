import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/core/di/dependency_injection.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/core/widgets/show_snackbar.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_state.dart';
import 'package:weight_tracker/features/splash/presentation/widgets/splash_screen_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!getIt.isRegistered<AuthCubit>()) {
      return const Scaffold(body: SplashScreenBody());
    }

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthSuccess ||
          current is AuthFailure ||
          current is AuthInitial,
      listener: (context, state) {
        switch (state) {
          case AuthSuccess _:
            Navigator.of(context).pushReplacementNamed(Routes.dashboardScreen);
            break;
          case AuthInitial _:
            Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
            break;
          case AuthFailure(:final message):
            showSnakBar(context, Colors.red, text: message);
            Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
            break;
          default:
            break;
        }
      },
      child: Scaffold(body: SplashScreenBody()),
    );
  }
}
