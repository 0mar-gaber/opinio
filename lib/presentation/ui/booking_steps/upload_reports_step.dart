import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../state/cubit/booking_cubit.dart';

class UploadReportsStep extends StatelessWidget {
  const UploadReportsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final filesMap = state.data['files'] as Map<String, dynamic>? ?? {};

        return ListView(
          children: [
            Text('Upload Reports', style: AppTextStyles.header3()),
            SizedBox(height: 8.h),
            Text(
              'Your medical reports and tests help doctors deliver clearer, more accurate second opinions.',
              style: AppTextStyles.bodyMedium(),
            ),
            SizedBox(height: 24.h),
            _card(context, 'Previous diagnosis reports * ', 'diagnosis',
                filesMap['diagnosis'] as List<dynamic>? ?? [], state.loadingReports.contains('diagnosis')),
            SizedBox(height: 16.h),
            _card(context, 'Lab test results *', 'lab_tests',
                filesMap['lab_tests'] as List<dynamic>? ?? [], state.loadingReports.contains('lab_tests')),
            SizedBox(height: 16.h),
            _card(context, 'Imaging scans (X-ray, MRI, CT) *', 'imaging',
                filesMap['imaging'] as List<dynamic>? ?? [], state.loadingReports.contains('imaging')),
            SizedBox(height: 16.h),
            _card(context, 'Current medication *', 'medication',
                filesMap['medication'] as List<dynamic>? ?? [], state.loadingReports.contains('medication')),
          ],
        );
      },
    );
  }

  Widget _card(
      BuildContext context, String title, String key, List<dynamic> files, bool isLoading) {
    final hasFiles = files.isNotEmpty;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.dorian,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTextStyles.bodyMedium()),
                Text(
                  isLoading 
                    ? "Processing..." 
                    : (hasFiles ? "${files.length} added file(s)" : "0 added file"),
                  style: AppTextStyles.small(color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          ElevatedButton(
            onPressed: isLoading ? null : () async {
              if (hasFiles) {
                context.read<BookingCubit>().clearFiles(key);
              } else {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  allowMultiple: true,
                  type: FileType.custom,
                  allowedExtensions: [
                    'pdf',
                    'doc',
                    'docx',
                    'jpg',
                    'png',
                    'jpeg'
                  ],
                );
                if (result != null) {
                  if (context.mounted) {
                    context.read<BookingCubit>().addFiles(key, result.files);
                  }
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: hasFiles ? Colors.white : AppColors.iris,
              foregroundColor: hasFiles ? AppColors.iris : Colors.white,
              disabledBackgroundColor: AppColors.iris.withValues(alpha: 0.7),
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: hasFiles
                    ? BorderSide(color: AppColors.iris)
                    : BorderSide.none,
              ),
              elevation: 0,
            ),
            child: isLoading 
              ? SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  hasFiles ? 'Clear' : 'Upload file',
                  style: AppTextStyles.buttonText().copyWith(
                    color: hasFiles ? AppColors.iris : Colors.white,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
