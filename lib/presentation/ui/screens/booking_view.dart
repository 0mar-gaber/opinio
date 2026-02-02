import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../state/cubit/booking_cubit.dart';
import '../booking_steps/specialty_step.dart';
import '../booking_steps/medical_info_step.dart';
import '../booking_steps/upload_reports_step.dart';
import '../booking_steps/doctor_selection_step.dart';
import '../booking_steps/date_time_step.dart';
import '../booking_steps/review_step.dart';
import '../booking_steps/success_step.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cloud,
      body: SafeArea(
        child: BlocBuilder<BookingCubit, BookingState>(
          builder: (context, state) {
            final percent = (state.currentStep / 7.0);
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Step ${state.currentStep} of 7', style: AppTextStyles.small()),
                          const Spacer(),
                          Text('${(percent * 100).round()}%', style: AppTextStyles.small(color: AppColors.textTertiary)),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      LinearProgressIndicator(
                        value: percent,
                        color: AppColors.iris,
                        backgroundColor: AppColors.dorian,
                        minHeight: 4.h,
                      ),
                      SizedBox(height: 12.h),
                      InkWell(
                        onTap: () => state.currentStep!= 1
                            ? context.read<BookingCubit>().previousStep()
                        : Navigator.pop(context),
                        borderRadius: BorderRadius.circular(24.r),
                        child: Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                            color: AppColors.cloud,
                            borderRadius: BorderRadius.circular(18.r),
                            boxShadow: [BoxShadow(color: AppColors.dorian, blurRadius: 8.r, offset: Offset(0, 2.h))],
                          ),
                          alignment: Alignment.center,
                          child: Icon(Icons.arrow_back, color: AppColors.textSecondary, size: 18.w),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: _buildStep(state.currentStep),
                  ),
                ),
                state.currentStep == 1
                ? SizedBox()
                :
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (state.currentStep == 2) {
                          final isValid = state.data['step2_valid'] == true;
                          if (!isValid) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please fill in all required fields'),
                                backgroundColor: AppColors.error,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            return;
                          }
                        } else if (state.currentStep == 3) {
                          final files = state.data['files'] as Map<String, dynamic>? ?? {};
                          final requiredKeys = ['diagnosis', 'lab_tests', 'imaging', 'medication'];
                          final hasAllFiles = requiredKeys.every((key) => 
                              files.containsKey(key) && 
                              (files[key] as List).isNotEmpty);
                          
                          if (!hasAllFiles) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please upload all required documents'),
                                backgroundColor: AppColors.error,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            return;
                          }
                        }
                        context.read<BookingCubit>().nextStep();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isContinueEnabled(state) 
                            ? AppColors.iris 
                            : AppColors.dorian,
                        foregroundColor: AppColors.cloud,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        elevation: 0,
                      ),
                      child: Text('Continue', style: AppTextStyles.buttonText(fontSize: 16.sp)),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStep(int step) {
    switch (step) {
      case 1:
        return const SpecialtyStep();
      case 2:
        return const MedicalInfoStep();
      case 3:
        return const UploadReportsStep();
      case 4:
        return const DoctorSelectionStep();
      case 5:
        return const DateTimeStep();
      case 6:
        return const ReviewStep();
      case 7:
        return const SuccessStep();
      default:
        return const SpecialtyStep();
    }
  }

  bool _isContinueEnabled(BookingState state) {
    if (state.currentStep == 2) {
      return state.data['step2_valid'] == true;
    } else if (state.currentStep == 3) {
      final files = state.data['files'] as Map<String, dynamic>? ?? {};
      final requiredKeys = ['diagnosis', 'lab_tests', 'imaging', 'medication'];
      return requiredKeys.every((key) => 
          files.containsKey(key) && 
          (files[key] as List).isNotEmpty);
    }
    return true;
  }
}
