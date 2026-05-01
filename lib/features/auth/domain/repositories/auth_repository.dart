import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<ApiResult<AuthUserEntity>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<ApiResult<AuthUserEntity>> registerWithEmail({
    required String email,
    required String password,
    String? fullName,
  });

  Future<ApiResult<AuthUserEntity>> loginWithGoogle();

  Future<ApiResult<AuthUserEntity?>> getCurrentUser();

  Future<ApiResult<void>> logout();
}
