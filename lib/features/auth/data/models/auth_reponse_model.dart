import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weight_tracker/features/auth/data/models/auth_user_model.dart';

class AuthResponseModel {
	final AuthUserModel user;
	final String? accessToken;
	final String? refreshToken;
	final int? expiresAt;

	const AuthResponseModel({
		required this.user,
		this.accessToken,
		this.refreshToken,
		this.expiresAt,
	});

	factory AuthResponseModel.fromSupabase(AuthResponse response) {
		final user = response.user;
		if (user == null) {
			throw StateError('Auth response does not include a user.');
		}
		final session = response.session;
		return AuthResponseModel(
			user: AuthUserModel.fromSupabase(user),
			accessToken: session?.accessToken,
			refreshToken: session?.refreshToken,
			expiresAt: session?.expiresAt,
		);
	}

	factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
		return AuthResponseModel(
			user: AuthUserModel.fromJson(json['user'] as Map<String, dynamic>),
			accessToken: json['access_token'] as String?,
			refreshToken: json['refresh_token'] as String?,
			expiresAt: json['expires_at'] as int?,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'user': user.toJson(),
			'access_token': accessToken,
			'refresh_token': refreshToken,
			'expires_at': expiresAt,
		};
	}
}
