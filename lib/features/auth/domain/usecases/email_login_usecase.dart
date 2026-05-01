import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/auth/domain/entities/auth_user.dart';
import 'package:weight_tracker/features/auth/domain/repositories/auth_repository.dart';

class EmailLoginUseCase {
  final AuthRepository repository;

  const EmailLoginUseCase({required this.repository});

  Future<ApiResult<AuthUserEntity>> call({
    required String email,
    required String password,
  }) {
    return repository.loginWithEmail(email: email, password: password);
  }
}
