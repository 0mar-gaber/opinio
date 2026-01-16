import 'package:flutter/material.dart';
import '../presentation/ui/screens/home_screen.dart';
import '../presentation/ui/screens/splash_screen.dart';
import '../presentation/ui/screens/onboarding_screen.dart';
import '../presentation/ui/screens/welcome_screen.dart';
import '../presentation/ui/screens/auth_screen.dart';
import '../presentation/ui/screens/verify_email_screen.dart';
import '../presentation/ui/screens/registration_steps_screen.dart';
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
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case AppRoutes.verifyEmail:
        final args = settings.arguments;
        final email = args is String ? args : (args is Map ? args['email'] as String? : null);
        return MaterialPageRoute(builder: (_) => VerifyEmailScreen(email: email ?? 'your@email.com'));
      case AppRoutes.registration:
        return MaterialPageRoute(builder: (_) => const RegistrationStepsScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      
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
