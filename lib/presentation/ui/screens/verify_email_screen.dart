import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../domain/entities/base_entity.dart';
import '../../../domain/usecases/base_usecase.dart';
import '../../../routes/app_routes.dart';

class VerifyEmailScreen extends StatefulWidget {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final ReloadCurrentUserUseCase reloadCurrentUserUseCase;
  final SendEmailVerificationUseCase sendEmailVerificationUseCase;

  const VerifyEmailScreen({
    super.key,
    required this.getCurrentUserUseCase,
    required this.reloadCurrentUserUseCase,
    required this.sendEmailVerificationUseCase,
  });

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool _isChecking = false;
  bool _isResending = false;
  AuthUser? _currentUser;

  @override
  void initState() {
    super.initState();
    widget.getCurrentUserUseCase(NoParams()).then((user) {
      if (!mounted) {
        return;
      }
      setState(() {
        _currentUser = user;
      });
    });
  }

  Future<void> _checkVerification() async {
    final user = await widget.getCurrentUserUseCase(NoParams());

    if (user == null) {
      if (!mounted) {
        return;
      }

      Navigator.pushReplacementNamed(context, AppRoutes.auth);
      return;
    }

    setState(() {
      _isChecking = true;
    });

    try {
      final refreshedUser =
          await widget.reloadCurrentUserUseCase(NoParams());

      if (!mounted) {
        return;
      }

      if (refreshedUser != null && refreshedUser.emailVerified) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your email is not verified yet.'),
          ),
        );
      }
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not check verification. Please try again.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isChecking = false;
        });
      }
    }
  }

  Future<void> _resendEmail() async {
    final user = await widget.getCurrentUserUseCase(NoParams());
    if (user == null) {
      if (!mounted) {
        return;
      }
      Navigator.pushReplacementNamed(context, AppRoutes.auth);
      return;
    }
    setState(() {
      _isResending = true;
    });
    try {
      await widget.sendEmailVerificationUseCase(NoParams());
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification email resent. Please check your inbox.'),
        ),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not resend email. Please try again.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = _currentUser?.email ?? '';

    return Scaffold(
      backgroundColor: AppColors.cloud,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              AppAssets.logoBlueWidget(
                width: 84.w,
                height: 40.w,
              ),
              SizedBox(height: 40.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Verify your email',
                  style: AppTextStyles.header3(),
                ),
              ),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  email.isNotEmpty
                      ? 'We sent a verification link to $email'
                      : 'We sent a verification link to your email address.',
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Please tap the link in your email, then come back here.',
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isChecking ? null : _checkVerification,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.iris,
                    foregroundColor: AppColors.cloud,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 0,
                  ),
                  child: _isChecking
                      ? SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.cloud,
                            ),
                          ),
                        )
                      : Text(
                          'I have verified',
                          style: AppTextStyles.buttonText(fontSize: 16.sp),
                        ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _isResending ? null : _resendEmail,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.iris,
                    side: BorderSide(
                      color: AppColors.iris,
                      width: 2,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: _isResending
                      ? SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(AppColors.iris),
                          ),
                        )
                      : Text(
                          'Resend email',
                          style: AppTextStyles.buttonText(
                            fontSize: 16.sp,
                            color: AppColors.iris,
                          ),
                        ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.auth,
                    arguments: 0,
                  );
                },
                child: Text(
                  'Back to sign in',
                  style: AppTextStyles.link(),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
