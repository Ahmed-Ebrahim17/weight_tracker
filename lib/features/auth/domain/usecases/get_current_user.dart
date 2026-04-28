import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/auth/domain/entities/auth_user.dart';
import 'package:weight_tracker/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
	final AuthRepository repository;

	const GetCurrentUserUseCase({required this.repository});

	Future<ApiResult<AuthUser?>> call() {
		return repository.getCurrentUser();
	}
}
