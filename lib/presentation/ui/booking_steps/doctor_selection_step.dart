import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/constants/app_assets.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_colors.dart';

class DoctorSelectionStep extends StatelessWidget {
  const DoctorSelectionStep({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Doctor', style: AppTextStyles.header3()),
        SizedBox(height: 8.h),
        Text('Choose your preferred specialist', style: AppTextStyles.bodyMedium(color: AppColors.textSecondary)),
        SizedBox(height: 16.h),
        TextField(
          decoration: InputDecoration(
            hintText: 'Search Doctor...',
            filled: true,
            fillColor: AppColors.cloud,
            prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
            border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.dorian), borderRadius: BorderRadius.circular(8.r)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.dorian), borderRadius: BorderRadius.circular(8.r)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.iris), borderRadius: BorderRadius.circular(8.r)),
          ),
        ),
        SizedBox(height: 16.h),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (_, i) => _doctorCard('Dr. Specialist $i', 'Cardiologist Consultant', 'New York, NY'),
          ),
        ),
      ],
    );
  }

  Widget _doctorCard(String name, String title, String location) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.cloud,
        borderRadius: BorderRadius.circular(16.r),
        border:  Border.all(color: AppColors.dorian)
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 32 .r, backgroundColor: AppColors.dorian,backgroundImage: NetworkImage("https://www.bartonassociates.com/wp-content/uploads/2021/04/Blog-Twitter-Facebook-1080x1080-44.jpg"),),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.bodyBold(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Container(
                      padding: REdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColors.evergreen.withOpacity(.6),

                      ),
                      child: Row(
                        children: [
                          AppAssets.starWidget(width: 16.w, height: 16.h),
                          SizedBox(width: 4.w),
                          Text('4.5', style: AppTextStyles.small(color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  title, 
                  style: AppTextStyles.small(color: AppColors.iris),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    AppAssets.yearsWidget(width: 16.w, height: 16.h),
                    SizedBox(width: 4.w),
                    Text("15 years", style: AppTextStyles.small(color: AppColors.textSecondary)),
                    Spacer(),
                    AppAssets.locationWidget(width: 16.w, height: 16.h),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        location, 
                        style: AppTextStyles.small(color: AppColors.textSecondary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    AppAssets.starWidget(width: 16.w, height: 16.h),
                    SizedBox(width: 4.w),
                    Text('342 reviews', style: AppTextStyles.small()),
                    Spacer(),
                    Text('\$150/session', style: AppTextStyles.small(color: AppColors.primary)),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
