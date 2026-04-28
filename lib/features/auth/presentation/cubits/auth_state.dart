import 'package:weight_tracker/features/auth/domain/entities/auth_user.dart';

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final AuthUser user;
  const AuthSuccess({required this.user});
}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure({required this.message});
}