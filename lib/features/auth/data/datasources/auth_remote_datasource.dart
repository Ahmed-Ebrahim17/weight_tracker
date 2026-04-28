import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weight_tracker/core/exceptions/auth_exceptions.dart';
import 'package:weight_tracker/features/auth/data/models/auth_reponse_model.dart';
import 'package:weight_tracker/features/auth/data/models/auth_user_model.dart';

abstract class AuthRemoteDataSource {
	Future<AuthResponseModel> loginWithEmail({
		required String email,
		required String password,
	});

	Future<AuthResponseModel> registerWithEmail({
		required String email,
		required String password,
		String? fullName,
	});

	Future<AuthResponseModel> loginWithGoogle();

	Future<AuthUserModel?> getCurrentUser();

	Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
	final SupabaseClient supabaseClient;
	final GoogleSignIn googleSignIn;

	const AuthRemoteDataSourceImpl({
		required this.supabaseClient,
		required this.googleSignIn,
	});

	@override
	Future<AuthResponseModel> loginWithEmail({
		required String email,
		required String password,
	}) async {
		try {
			final response = await supabaseClient.auth.signInWithPassword(
				email: email,
				password: password,
			);
			return AuthResponseModel.fromSupabase(response);
		} on AuthException catch (e) {
			throw _mapSupabaseAuthException(e);
		} on SocketException {
			throw const NetworkAuthException('No internet connection.');
		} catch (e) {
			throw const UnknownAuthException('Login failed.');
		}
	}

	@override
	Future<AuthResponseModel> registerWithEmail({
		required String email,
		required String password,
		String? fullName,
	}) async {
		try {
			final response = await supabaseClient.auth.signUp(
				email: email,
				password: password,
				data: fullName == null ? null : {'full_name': fullName},
			);
			return AuthResponseModel.fromSupabase(response);
		} on AuthException catch (e) {
			throw _mapSupabaseAuthException(e);
		} on SocketException {
			throw const NetworkAuthException('No internet connection.');
		} catch (e) {
			throw const UnknownAuthException('Registration failed.');
		}
	}

	@override
	Future<AuthResponseModel> loginWithGoogle() async {
		try {
			final googleUser = await googleSignIn.authenticate();
			final googleAuth = googleUser.authentication;
			final idToken = googleAuth.idToken;
			
			if (idToken == null) {
				throw const UnknownAuthException('Missing Google ID token.');
			}

			final response = await supabaseClient.auth.signInWithIdToken(
				provider: OAuthProvider.google,
				idToken: idToken,
			);

			return AuthResponseModel.fromSupabase(response);
		} on AuthException catch (e) {
			throw _mapSupabaseAuthException(e);
		} on SocketException {
			throw const NetworkAuthException('No internet connection.');
		} catch (e) {
			if (e is AuthExceptionBase) {
				rethrow;
			}
			// Log the actual error for debugging
			throw UnknownAuthException('Google login failed: ${e.toString()}');
		}
	}

	@override
	Future<AuthUserModel?> getCurrentUser() async {
		try {
			final user = supabaseClient.auth.currentUser;
			if (user == null) {
				return null;
			}
			return AuthUserModel.fromSupabase(user);
		} catch (e) {
			throw const UnknownAuthException('Failed to read current user.');
		}
	}

	@override
	Future<void> logout() async {
		try {
			await supabaseClient.auth.signOut();
		} on AuthException catch (e) {
			throw _mapSupabaseAuthException(e);
		} catch (e) {
			throw const UnknownAuthException('Logout failed.');
		}
	}

	AuthExceptionBase _mapSupabaseAuthException(AuthException exception) {
		final message = exception.message.toLowerCase();

		if (message.contains('invalid login credentials') ||
				message.contains('invalid credentials')) {
			return const InvalidCredentialsException('Invalid email or password.');
		}

		if (message.contains('email') && message.contains('invalid')) {
			return const InvalidEmailException('Invalid email address.');
		}

		if (message.contains('already registered') || message.contains('already exists')) {
			return const EmailAlreadyInUseException('Email already registered.');
		}

		if (message.contains('password') && message.contains('weak')) {
			return const WeakPasswordException('Password is too weak.');
		}

		return UnknownAuthException(exception.message);
	}
}
