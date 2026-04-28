import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
	final AuthRepository repository;

	const LogoutUseCase({required this.repository});

	Future<ApiResult<void>> call() {
		return repository.logout();
	}
}
