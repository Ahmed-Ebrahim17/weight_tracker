import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
	Future<ApiResult<AuthUser>> loginWithEmail({
		required String email,
		required String password,
	});

	Future<ApiResult<AuthUser>> registerWithEmail({
		required String email,
		required String password,
		String? fullName,
	});

	Future<ApiResult<AuthUser>> loginWithGoogle();

	Future<ApiResult<AuthUser?>> getCurrentUser();

	Future<ApiResult<void>> logout();
}
