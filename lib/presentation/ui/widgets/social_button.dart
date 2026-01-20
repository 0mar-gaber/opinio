import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const SocialButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  Widget _getIcon() {
    if (text.toLowerCase().contains('google')) {
      return AppAssets.googleWidget(width: 24.w, height: 24.h);
    } else if (text.toLowerCase().contains('apple')) {
      // Use Material icon for Apple (or add apple.svg if available)
      return Icon(
        Icons.apple,
        size: 24.sp,
        color: AppColors.textPrimary,
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.cloud,
          foregroundColor: AppColors.textPrimary,
          side: BorderSide(
            color: AppColors.dorian,
            width: 1,
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.textPrimary,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getIcon(),
                  SizedBox(width: 12.w),
                  Text(
                    text,
                    style: AppTextStyles.bodyMedium(),
                  ),
                ],
              ),
      ),
    );
  }
}
