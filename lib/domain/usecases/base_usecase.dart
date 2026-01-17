import '../entities/base_entity.dart';
import '../../data/repositories/auth_repository.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Type> call(Params params);
}

class NoParams {}

class SignInParams {
  final String email;
  final String password;

  SignInParams({
    required this.email,
    required this.password,
  });
}

class SignUpParams {
  final String name;
  final String email;
  final String password;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}

class SignInWithEmailAndPasswordUseCase
    extends BaseUseCase<AuthUser, SignInParams> {
  final AuthRepository _repository;

  SignInWithEmailAndPasswordUseCase(this._repository);

  @override
  Future<AuthUser> call(SignInParams params) {
    return _repository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpWithEmailAndPasswordUseCase
    extends BaseUseCase<AuthUser, SignUpParams> {
  final AuthRepository _repository;

  SignUpWithEmailAndPasswordUseCase(this._repository);

  @override
  Future<AuthUser> call(SignUpParams params) {
    return _repository.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class GetCurrentUserUseCase
    extends BaseUseCase<AuthUser?, NoParams> {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  @override
  Future<AuthUser?> call(NoParams params) {
    return _repository.getCurrentUser();
  }
}

class ReloadCurrentUserUseCase
    extends BaseUseCase<AuthUser?, NoParams> {
  final AuthRepository _repository;

  ReloadCurrentUserUseCase(this._repository);

  @override
  Future<AuthUser?> call(NoParams params) {
    return _repository.reloadCurrentUser();
  }
}

class SendEmailVerificationUseCase
    extends BaseUseCase<void, NoParams> {
  final AuthRepository _repository;

  SendEmailVerificationUseCase(this._repository);

  @override
  Future<void> call(NoParams params) {
    return _repository.sendEmailVerification();
  }
}
