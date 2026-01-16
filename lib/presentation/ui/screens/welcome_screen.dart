import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cloud,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Spacer(),
              // Logo or app icon
              AppAssets.logoBlueWidget(
                width: 120.w,
                height: 120.w,
              ),
              
              SizedBox(height: 32.h),

              // Get Started Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to auth screen (Sign Up tab)
                    Navigator.pushNamed(context, AppRoutes.auth);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.iris,
                    foregroundColor: AppColors.cloud,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 16.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Get Started',
                    style: AppTextStyles.buttonText(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // Sign In Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Navigate to auth screen (Sign In tab)
                    Navigator.pushNamed(context, AppRoutes.auth);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.iris,
                    side: BorderSide(
                      color: AppColors.iris,
                      width: 2,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 16.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: AppTextStyles.buttonText(
                      fontSize: 16.sp,
                      color: AppColors.iris,
                    ),
                  ),
                ),
              ),
              
              const Spacer(),
              
              // Bottom section for doctors
              Padding(
                padding: EdgeInsets.only(bottom: 40.h),
                child: Column(
                  children: [
                    Text(
                      'Are you a doctor?',
                      style: AppTextStyles.bodyMedium(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Apply to join our verified network',
                      style: AppTextStyles.link(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
