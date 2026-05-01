class AuthUserEntity {
  final String id;
  final String email;
  final String? fullName;

  const AuthUserEntity({required this.id, required this.email, this.fullName});
}
