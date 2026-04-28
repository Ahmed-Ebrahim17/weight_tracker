import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/core/helper/extensions.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/core/widgets/show_snackbar.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_state.dart';

class RegisterBlocListener extends StatefulWidget {
  const RegisterBlocListener({super.key});

  @override
  State<RegisterBlocListener> createState() => _RegisterBlocListenerState();
}

class _RegisterBlocListenerState extends State<RegisterBlocListener> {
  bool isFirstFailure = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit,AuthState>(
      listenWhen: (previous, current) => current is
      AuthLoading ||current is AuthSuccess || current is AuthFailure,
      listener: (context, state) {
        switch (state) {
          case AuthLoading _:
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(child: CircularProgressIndicator()),
            );
            break;
          case AuthSuccess _:
            // Hide loading indicator and navigate to home screen
            isFirstFailure = true; // Reset for next auth attempt
            context.pop(); // Hide loading dialog
            context.pushNamed(Routes.homeScreen);
            break;
          case AuthFailure(:final message):
            // Suppress error if it's the very first failure emission (likely initialization error)
            if (isFirstFailure) {
              isFirstFailure = false;
              return;
            }
            // Hide loading indicator and show error message
            context.pop(); // Hide loading dialog
           showSnakBar(context, Colors.red, text: message);
            break;
          default:
            break;
        }
      },
      child: const SizedBox.shrink(),
    );  }
}