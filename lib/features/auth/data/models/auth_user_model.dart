import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weight_tracker/features/auth/domain/entities/auth_user.dart'
    as entities;

class AuthUserModel extends entities.AuthUserEntity {
  const AuthUserModel({
    required super.id,
    required super.email,
    super.fullName,
  });

  factory AuthUserModel.fromSupabase(User user) {
    final metadata = user.userMetadata;
    final fullName = metadata?['full_name'] ?? metadata?['fullName'];
    return AuthUserModel(
      id: user.id,
      email: user.email ?? '',
      fullName: fullName is String ? fullName : null,
    );
  }

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      fullName: json['full_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'full_name': fullName};
  }
}
