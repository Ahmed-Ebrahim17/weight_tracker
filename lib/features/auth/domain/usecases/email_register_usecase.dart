import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/auth/domain/entities/auth_user.dart';
import 'package:weight_tracker/features/auth/domain/repositories/auth_repository.dart';

class EmailRegisterUseCase {
	final AuthRepository repository;

	const EmailRegisterUseCase({required this.repository});

	Future<ApiResult<AuthUser>> call({
		required String email,
		required String password,
		String? fullName,
	}) {
		return repository.registerWithEmail(
			email: email,
			password: password,
			fullName: fullName,
		);
	}
}
