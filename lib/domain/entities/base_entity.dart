abstract class BaseEntity {}

class AuthUser extends BaseEntity {
  final String id;
  final String? email;
  final bool emailVerified;
  final String? displayName;

  AuthUser({
    required this.id,
    required this.email,
    required this.emailVerified,
    required this.displayName,
  });
}
