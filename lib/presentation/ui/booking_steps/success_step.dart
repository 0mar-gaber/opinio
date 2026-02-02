import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';

class SuccessStep extends StatelessWidget {
  const SuccessStep({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppAssets.calendarWidget(width: 64.w, height: 64.w, color: AppColors.iris),
          SizedBox(height: 24.h),
          Text('Booking Confirmed', style: AppTextStyles.header3()),
          SizedBox(height: 8.h),
          Text('You will receive details via email', style: AppTextStyles.bodyMedium(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
