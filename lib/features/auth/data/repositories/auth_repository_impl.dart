import 'package:dartz/dartz.dart';
import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/core/error/failure.dart';
import 'package:weight_tracker/core/exceptions/auth_exceptions.dart';
import 'package:weight_tracker/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:weight_tracker/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:weight_tracker/features/auth/domain/entities/auth_user.dart';
import 'package:weight_tracker/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
	final AuthRemoteDataSource remoteDataSource;
	final AuthLocalDataSource localDataSource;

	const AuthRepositoryImpl({
		required this.remoteDataSource,
		required this.localDataSource,
	});

	@override
	Future<ApiResult<AuthUser>> loginWithEmail({
		required String email,
		required String password,
	}) async {
		try {
			final response = await remoteDataSource.loginWithEmail(
				email: email,
				password: password,
			);
			await localDataSource.cacheAuthResponse(response);
			return Right(response.user);
		} on AuthExceptionBase catch (e) {
			return Left(_mapExceptionToFailure(e));
		} catch (e) {
			return const Left(UnknownFailure('Unexpected error.'));
		}
	}

	@override
	Future<ApiResult<AuthUser>> registerWithEmail({
		required String email,
		required String password,
		String? fullName,
	}) async {
		try {
			final response = await remoteDataSource.registerWithEmail(
				email: email,
				password: password,
				fullName: fullName,
			);
			await localDataSource.cacheAuthResponse(response);
			return Right(response.user);
		} on AuthExceptionBase catch (e) {
			return Left(_mapExceptionToFailure(e));
		} catch (e) {
			return const Left(UnknownFailure('Unexpected error.'));
		}
	}

	@override
	Future<ApiResult<AuthUser>> loginWithGoogle() async {
		try {
			final response = await remoteDataSource.loginWithGoogle();
			await localDataSource.cacheAuthResponse(response);
			return Right(response.user);
		} on AuthExceptionBase catch (e) {
			return Left(_mapExceptionToFailure(e));
		} catch (e) {
			return const Left(UnknownFailure('Unexpected error.'));
		}
	}

	@override
	Future<ApiResult<AuthUser?>> getCurrentUser() async {
		try {
			final user = await remoteDataSource.getCurrentUser();
			return Right(user);
		} on AuthExceptionBase catch (e) {
			return Left(_mapExceptionToFailure(e));
		} catch (e) {
			return const Left(UnknownFailure('Unexpected error.'));
		}
	}

	@override
	Future<ApiResult<void>> logout() async {
		try {
			await remoteDataSource.logout();
			await localDataSource.clear();
			return const Right(null);
		} on AuthExceptionBase catch (e) {
			return Left(_mapExceptionToFailure(e));
		} catch (e) {
			return const Left(UnknownFailure('Unexpected error.'));
		}
	}

	Failure _mapExceptionToFailure(AuthExceptionBase exception) {
		return switch (exception) {
			InvalidEmailException() => ValidationFailure(exception.message),
			WeakPasswordException() => ValidationFailure(exception.message),
			EmailAlreadyInUseException() => ValidationFailure(exception.message),
			InvalidCredentialsException() => AuthFailure(exception.message),
			UserNotFoundException() => AuthFailure(exception.message),
			GoogleSignInCanceledException() => AuthFailure(exception.message),
			NetworkAuthException() => NetworkFailure(exception.message),
			UnknownAuthException() => UnknownFailure(exception.message),
		};
	}
}
