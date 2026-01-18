import '../../data/datasources/remote_datasource.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/services/google_auth_service.dart';
import '../../domain/usecases/base_usecase.dart';
import '../../presentation/state/cubit/auth_cubit.dart';

class AppDependencies {
  AppDependencies._();

  static final RemoteDataSource _remoteDataSource = RemoteDataSource();
  static final AuthRepository _authRepository =
      AuthRepositoryImpl(_remoteDataSource);
  static final GoogleAuthService googleAuthService = GoogleAuthService();

  static final SignInWithEmailAndPasswordUseCase signInUseCase =
      SignInWithEmailAndPasswordUseCase(_authRepository);
  static final SignUpWithEmailAndPasswordUseCase signUpUseCase =
      SignUpWithEmailAndPasswordUseCase(_authRepository);
  static final GetCurrentUserUseCase getCurrentUserUseCase =
      GetCurrentUserUseCase(_authRepository);
  static final ReloadCurrentUserUseCase reloadCurrentUserUseCase =
      ReloadCurrentUserUseCase(_authRepository);
  static final SendEmailVerificationUseCase sendEmailVerificationUseCase =
      SendEmailVerificationUseCase(_authRepository);

  static final AuthCubit authCubit = AuthCubit(
    signInUseCase: signInUseCase,
    signUpUseCase: signUpUseCase,
    getCurrentUserUseCase: getCurrentUserUseCase,
    reloadCurrentUserUseCase: reloadCurrentUserUseCase,
    sendEmailVerificationUseCase: sendEmailVerificationUseCase,
  );
}
