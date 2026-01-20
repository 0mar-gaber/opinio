import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../domain/usecases/base_usecase.dart';
import '../../../routes/app_routes.dart';

class ResetPasswordScreen extends StatefulWidget {
  final SendPasswordResetEmailUseCase sendPasswordResetEmailUseCase;

  const ResetPasswordScreen({
    super.key,
    required this.sendPasswordResetEmailUseCase,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendReset() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSending = true);
    try {
      final email = _emailController.text.trim();
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      if (query.docs.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('No account found for this email.'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
      await widget.sendPasswordResetEmailUseCase(
        ResetPasswordParams(email: email),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent. Check your inbox.'),
        ),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.auth, arguments: 0);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Could not send reset email. Please try again.'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cloud,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Align(
                child: AppAssets.logoBlueWidget(
                  width: 84.w,
                  height: 40.w,
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'Reset your password',
                style: AppTextStyles.header3(),
              ),
              SizedBox(height: 12.h),
              Text(
                'Enter your email to receive a reset link.',
                style: AppTextStyles.bodyMedium(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 24.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: AppColors.cloud,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: AppAssets.personWidget(
                            width: 20.w,
                            height: 20.h,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: AppColors.dorian),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: AppColors.iris),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: AppColors.error),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSending ? null : _sendReset,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.iris,
                          foregroundColor: AppColors.cloud,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          elevation: 0,
                        ),
                        child: _isSending
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
                                'Send Reset Link',
                                style:
                                    AppTextStyles.buttonText(fontSize: 16.sp),
                              ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      child: TextButton(
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
