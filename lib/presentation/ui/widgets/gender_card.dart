import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class GenderCard extends StatelessWidget {
  final String label;
  final Widget icon;
  final bool selected;
  final VoidCallback onTap;

  const GenderCard({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.cloud,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected ? AppColors.iris : AppColors.dorian,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? AppColors.iris : AppColors.textTertiary,
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }
}
