sealed class AuthExceptionBase implements Exception {
	final String message;

	const AuthExceptionBase(this.message);

	@override
	String toString() => message;
}

class InvalidEmailException extends AuthExceptionBase {
	const InvalidEmailException(super.message);
}

class WeakPasswordException extends AuthExceptionBase {
	const WeakPasswordException(super.message);
}

class EmailAlreadyInUseException extends AuthExceptionBase {
	const EmailAlreadyInUseException(super.message);
}

class InvalidCredentialsException extends AuthExceptionBase {
	const InvalidCredentialsException(super.message);
}

class UserNotFoundException extends AuthExceptionBase {
	const UserNotFoundException(super.message);
}

class GoogleSignInCanceledException extends AuthExceptionBase {
	const GoogleSignInCanceledException(super.message);
}

class NetworkAuthException extends AuthExceptionBase {
	const NetworkAuthException(super.message);
}

class UnknownAuthException extends AuthExceptionBase {
	const UnknownAuthException(super.message);
}
