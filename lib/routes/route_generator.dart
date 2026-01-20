import 'package:flutter/material.dart';
import '../core/utils/helpers.dart';
import '../presentation/ui/screens/home_screen.dart';
import '../presentation/ui/screens/splash_screen.dart';
import '../presentation/ui/screens/onboarding_screen.dart';
import '../presentation/ui/screens/welcome_screen.dart';
import '../presentation/ui/screens/auth_screen.dart';
import '../presentation/ui/screens/verify_email_screen.dart';
import '../presentation/ui/screens/step_registration_screen.dart';
import '../presentation/ui/screens/reset_password_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRoutes.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case AppRoutes.auth:
        return MaterialPageRoute(
          builder: (_) {
            final initialIndex = (settings.arguments as int?) ?? 0;
            return AuthScreen(
              signInUseCase: AppDependencies.signInUseCase,
              signUpUseCase: AppDependencies.signUpUseCase,
              reloadCurrentUserUseCase:
                  AppDependencies.reloadCurrentUserUseCase,
              sendEmailVerificationUseCase:
                  AppDependencies.sendEmailVerificationUseCase,
              authCubit: AppDependencies.authCubit,
              initialTabIndex: initialIndex,
            );
          },
        );
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.verifyEmail:
        return MaterialPageRoute(
          builder: (_) => VerifyEmailScreen(
            getCurrentUserUseCase: AppDependencies.getCurrentUserUseCase,
            reloadCurrentUserUseCase:
                AppDependencies.reloadCurrentUserUseCase,
            sendEmailVerificationUseCase:
                AppDependencies.sendEmailVerificationUseCase,
          ),
        );
      case AppRoutes.stepRegistration:
        return MaterialPageRoute(
          builder: (_) => const StepRegistrationScreen(),
        );
      case AppRoutes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(
            sendPasswordResetEmailUseCase:
                AppDependencies.sendPasswordResetEmailUseCase,
          ),
        );
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
