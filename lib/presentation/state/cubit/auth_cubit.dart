import '../../../domain/entities/base_entity.dart';
import '../../../domain/usecases/base_usecase.dart';
import 'base_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final AuthUser user;
  AuthAuthenticated(this.user);
}

class AuthEmailNotVerified extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthCubit extends BaseCubit<AuthState> {
  final SignInWithEmailAndPasswordUseCase signInUseCase;
  final SignUpWithEmailAndPasswordUseCase signUpUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final ReloadCurrentUserUseCase reloadCurrentUserUseCase;
  final SendEmailVerificationUseCase sendEmailVerificationUseCase;

  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.getCurrentUserUseCase,
    required this.reloadCurrentUserUseCase,
    required this.sendEmailVerificationUseCase,
  }) : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await signInUseCase(SignInParams(email: email, password: password));
      if (user.emailVerified) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthEmailNotVerified());
      }
    } catch (e) {
      emit(AuthError(_mapError(e)));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await signUpUseCase(SignUpParams(name: name, email: email, password: password));
      await sendEmailVerificationUseCase(NoParams());
      emit(AuthEmailNotVerified());
    } catch (e) {
      emit(AuthError(_mapError(e)));
    }
  }

  String _mapError(Object e) {
    final text = e.toString();
    if (text.contains('wrong-password')) {
      return 'Incorrect password';
    }
    if (text.contains('user-not-found')) {
      return 'No user found for that email';
    }
    if (text.contains('email-already-in-use')) {
      return 'Email is already in use';
    }
    if (text.contains('network-request-failed')) {
      return 'Network error. Check your connection';
    }
    return 'Something went wrong. Please try again';
  }
}
