import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/features/auth/domain/entities/auth_user.dart';
import 'package:weight_tracker/core/error/failure.dart' as failures;

import 'package:weight_tracker/features/auth/domain/usecases/email_login_usecase.dart';
import 'package:weight_tracker/features/auth/domain/usecases/email_register_usecase.dart';
import 'package:weight_tracker/features/auth/domain/usecases/get_current_user.dart';
import 'package:weight_tracker/features/auth/domain/usecases/google_login_usecase.dart';
import 'package:weight_tracker/features/auth/domain/usecases/logout_usecase.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final EmailLoginUseCase emailLoginUseCase;
  final EmailRegisterUseCase emailRegisterUseCase;
  final GoogleLoginUseCase googleLoginUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final LogoutUseCase logoutUseCase;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  

  AuthCubit({
    required this.emailLoginUseCase,
    required this.emailRegisterUseCase,
    required this.googleLoginUseCase,
    required this.getCurrentUserUseCase,
    required this.logoutUseCase,
  }) : super( AuthInitial());

  AuthUserEntity? get currentUser {
    final currentState = state;
    if (currentState is AuthSuccess) {
      return currentState.user;
    }
    return null;
  }

  String get currentUserName {
    final name = currentUser?.fullName;
    if (name != null && name.trim().isNotEmpty) {
      return name.trim().split(' ').first;
    }
    return currentUser?.email.split('@').first ?? 'User';
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    final result = await emailLoginUseCase(email: email, password: password);
    result.fold(
      (failure) => emit(AuthFailure(message: _mapFailureToMessage(failure))),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> registerWithEmail({
    required String email,
    required String password,
    String? fullName,
  }) async {
    emit(const AuthLoading());
    final result = await emailRegisterUseCase(
      email: email,
      password: password,
      fullName: fullName,
    );
    result.fold(
      (failure) => emit(AuthFailure(message: _mapFailureToMessage(failure))),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> loginWithGoogle() async {
    emit(const AuthLoading());
    final result = await googleLoginUseCase();
    result.fold(
      (failure) => emit(AuthFailure(message: _mapFailureToMessage(failure))),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> loadCurrentUser() async {
    final result = await getCurrentUserUseCase();
    result.fold(
      (failure) => emit(AuthFailure(message: _mapFailureToMessage(failure))),
      (user) {
        if (user == null) {
          emit(const AuthInitial());
        } else {
          emit(AuthSuccess(user: user));
        }
      },
    );
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    final result = await logoutUseCase();
    result.fold(
      (failure) => emit(AuthFailure(message: _mapFailureToMessage(failure))),
      (_) => emit(const AuthInitial()),
    );
  }

  String _mapFailureToMessage(failures.Failure failure) {
    return switch (failure) {
      failures.NetworkFailure() => 'No internet connection. Please try again.',
      failures.ValidationFailure() => failure.message,
      failures.AuthFailure() => failure.message.isEmpty
          ? 'Authentication failed. Please try again.'
          : failure.message,
      failures.ServerFailure() => 'Server error. Please try again later.',
      failures.UnknownFailure() => 'Unexpected error. Please try again.',
    };
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}