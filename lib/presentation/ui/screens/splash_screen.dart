import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  _navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    }
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
