import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/usecases/base_usecase.dart';
import '../../../core/utils/helpers.dart';
 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _decideStartRoute();
  }

  Future<bool> _isProfileCompleted(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = doc.data() ?? {};
    final completed = (data['profileCompleted'] as bool?) ?? false;
    final firstName = (data['firstName'] as String?) ?? '';
    final lastName = (data['lastName'] as String?) ?? '';
    final age = (data['age'] as int?) ?? 0;
    final gender = (data['gender'] as String?) ?? '';
    if (completed) return true;
    if (firstName.isNotEmpty && lastName.isNotEmpty && age > 0 && gender.isNotEmpty) return true;
    return false;
  }

  Future<void> _decideStartRoute() async {
    await Future.delayed(const Duration(seconds: 2));
    final user = await AppDependencies.getCurrentUserUseCase(NoParams());
    if (!mounted) return;
    if (user != null) {
      if (user.emailVerified) {
        final completed = await _isProfileCompleted(user.id);
        if (!mounted) return;
        if (completed) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.stepRegistration);
        }
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.verifyEmail);
      }
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('onboarding_seen') ?? false;
    final nextRoute = seen ? AppRoutes.welcome : AppRoutes.onboarding;
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, nextRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 1️⃣ الخلفية كلها
          Container(
            color: AppColors.secondary,
          ),

          /// 2️⃣ الجزء الأزرق بالكيرف
          ClipPath(
            clipper: BottomCurveClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: double.infinity,
              color: AppColors.primary,
            ),
          ),

          /// 3️⃣ اللوجو في النص
          Center(
            child: AppAssets.logoWhiteWidget(),
          ),
        ],
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 60);

    path.quadraticBezierTo(
      size.width / 2,
      size.height + 60,
      size.width,
      size.height - 80,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
