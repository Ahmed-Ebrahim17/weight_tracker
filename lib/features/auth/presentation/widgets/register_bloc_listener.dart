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
  bool _isLoadingDialogVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthLoading ||
          current is AuthSuccess ||
          current is AuthFailure,
      listener: (context, state) {
        switch (state) {
          case AuthLoading _:
            _showLoadingDialog(context);
            break;
          case AuthSuccess _:
            _hideLoadingDialog(context);
            context.pushReplacementNamed(Routes.dashboardScreen);
            break;
          case AuthFailure(:final message):
            _hideLoadingDialog(context);
            showSnakBar(context, Colors.red, text: message);
            break;
          default:
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Future<void> _showLoadingDialog(BuildContext context) async {
    if (_isLoadingDialogVisible || !mounted) {
      return;
    }

    _isLoadingDialogVisible = true;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    _isLoadingDialogVisible = false;
  }

  void _hideLoadingDialog(BuildContext context) {
    if (!_isLoadingDialogVisible || !mounted) {
      return;
    }

    Navigator.of(context, rootNavigator: true).pop();
    _isLoadingDialogVisible = false;
  }
}
