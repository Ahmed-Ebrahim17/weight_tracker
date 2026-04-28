import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_tracker/features/auth/data/models/auth_reponse_model.dart';
import 'package:weight_tracker/features/auth/data/models/auth_user_model.dart';

abstract class AuthLocalDataSource {
	Future<void> cacheAuthResponse(AuthResponseModel response);
	Future<AuthUserModel?> getCachedUser();
	Future<void> clear();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
	final SharedPreferences sharedPreferences;

	const AuthLocalDataSourceImpl({required this.sharedPreferences});

	static const _userKey = 'auth_user';
	static const _accessTokenKey = 'auth_access_token';
	static const _refreshTokenKey = 'auth_refresh_token';
	static const _expiresAtKey = 'auth_expires_at';

	@override
	Future<void> cacheAuthResponse(AuthResponseModel response) async {
		await sharedPreferences.setString(
			_userKey,
			jsonEncode(response.user.toJson()),
		);

		if (response.accessToken == null) {
			await sharedPreferences.remove(_accessTokenKey);
		} else {
			await sharedPreferences.setString(_accessTokenKey, response.accessToken!);
		}

		if (response.refreshToken == null) {
			await sharedPreferences.remove(_refreshTokenKey);
		} else {
			await sharedPreferences.setString(_refreshTokenKey, response.refreshToken!);
		}

		if (response.expiresAt == null) {
			await sharedPreferences.remove(_expiresAtKey);
		} else {
			await sharedPreferences.setInt(_expiresAtKey, response.expiresAt!);
		}
	}

	@override
	Future<AuthUserModel?> getCachedUser() async {
		final raw = sharedPreferences.getString(_userKey);
		if (raw == null) {
			return null;
		}
		return AuthUserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
	}

	@override
	Future<void> clear() async {
		await sharedPreferences.remove(_userKey);
		await sharedPreferences.remove(_accessTokenKey);
		await sharedPreferences.remove(_refreshTokenKey);
		await sharedPreferences.remove(_expiresAtKey);
	}
}
