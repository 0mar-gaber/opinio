import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class AuthHeader extends StatelessWidget {
  final int? step;
  final int? totalSteps;
  final String? title;

  const AuthHeader({
    super.key,
    this.step,
    this.totalSteps,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        if (step != null && totalSteps != null) ...[
          SizedBox(height: 16.h),
          Text(
            'Step ${step!} of ${totalSteps!}',
            style: AppTextStyles.small(color: AppColors.textPrimary),
          ),
          SizedBox(height: 8.h),
          Container(
            height: 4.h,
            width: double.infinity,
            margin: REdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: AppColors.dorian,
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: FractionallySizedBox(
              widthFactor: (step!.clamp(0, totalSteps!) / totalSteps!).toDouble(),
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          ),
        ],
        if (title != null) ...[
          SizedBox(height: 24.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(title!, style: AppTextStyles.header3()),
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 3.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: AppColors.evergreen,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
