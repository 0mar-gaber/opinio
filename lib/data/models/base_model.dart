import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/base_entity.dart';

abstract class BaseModel {}

class AuthUserModel extends BaseModel {
  final String id;
  final String? email;
  final bool emailVerified;
  final String? displayName;

  AuthUserModel({
    required this.id,
    required this.email,
    required this.emailVerified,
    required this.displayName,
  });

  factory AuthUserModel.fromFirebaseUser(User user) {
    return AuthUserModel(
      id: user.uid,
      email: user.email,
      emailVerified: user.emailVerified,
      displayName: user.displayName,
    );
  }

  AuthUser toEntity() {
    return AuthUser(
      id: id,
      email: email,
      emailVerified: emailVerified,
      displayName: displayName,
    );
  }
}
