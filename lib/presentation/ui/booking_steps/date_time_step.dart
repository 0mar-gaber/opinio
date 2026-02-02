import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_colors.dart';

class DateTimeStep extends StatefulWidget {
  const DateTimeStep({super.key});
  @override
  State<DateTimeStep> createState() => _DateTimeStepState();
}

class _DateTimeStepState extends State<DateTimeStep> {
  int selectedDateIndex = 1;
  int selectedTimeIndex = 8;
  final dates = ['Fri 2', 'Sat 3', 'Sun 4', 'Mon 5', 'Tue 6'];
  final times = ['09:00 AM','09:30 AM','10:00 AM','10:30 AM','11:00 AM','11:30 AM','02:00 PM','02:30 PM','03:00 PM','03:30 PM','04:00 PM','04:30 PM'];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Date & Time', style: AppTextStyles.header3()),
        SizedBox(height: 8.h),
        Text('Choose your preferred consultation slot', style: AppTextStyles.bodyMedium(color: AppColors.textSecondary)),
        SizedBox(height: 16.h),
        Text('Select Date', style: AppTextStyles.small()),
        SizedBox(height: 12.h),
        SizedBox(
          height: 48.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (_, i) {
              final selected = i == selectedDateIndex;
              return GestureDetector(
                onTap: () => setState(() => selectedDateIndex = i),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.iris : AppColors.cloud,
                    border: Border.all(color: AppColors.dorian),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    dates[i],
                    style: AppTextStyles.bodyMedium(color: selected ? AppColors.cloud : AppColors.textSecondary),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.h),
        Text('Select Time', style: AppTextStyles.small()),
        SizedBox(height: 12.h),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 2.8,
            ),
            itemCount: times.length,
            itemBuilder: (_, i) {
              final selected = i == selectedTimeIndex;
              return GestureDetector(
                onTap: () => setState(() => selectedTimeIndex = i),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.iris : AppColors.cloud,
                    border: Border.all(color: AppColors.dorian),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    times[i],
                    style: AppTextStyles.small(color: selected ? AppColors.cloud : AppColors.textSecondary),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
