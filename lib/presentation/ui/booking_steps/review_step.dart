import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_colors.dart';

class ReviewStep extends StatelessWidget {
  const ReviewStep({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Review', style: AppTextStyles.header3()),
        SizedBox(height: 8.h),
        Text('Summary of your booking details', style: AppTextStyles.bodyMedium(color: AppColors.textSecondary)),
        SizedBox(height: 16.h),
        Expanded(
          child: ListView(
            children: [
              _row('Specialty', 'Cardiology'),
              _row('Doctor', 'Dr. Specialist'),
              _row('Date', 'Sat 3'),
              _row('Time', '03:00 PM'),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.iris,
              foregroundColor: AppColors.cloud,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              elevation: 0,
            ),
            child: Text('Confirm', style: AppTextStyles.buttonText(fontSize: 16.sp)),
          ),
        ),
      ],
    );
  }

  Widget _row(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.dorian)),
      ),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppTextStyles.bodyMedium())),
          Text(value, style: AppTextStyles.bodyBold()),
        ],
      ),
    );
  }
}
