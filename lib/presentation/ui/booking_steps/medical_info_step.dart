import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_colors.dart';
import '../../state/cubit/booking_cubit.dart';

class MedicalInfoStep extends StatefulWidget {
  const MedicalInfoStep({super.key});

  @override
  State<MedicalInfoStep> createState() => _MedicalInfoStepState();
}

class _MedicalInfoStepState extends State<MedicalInfoStep> {
  late TextEditingController _concernController;
  late TextEditingController _historyController;
  String? _selectedDuration;
  String? _selectedOpinionType;

  final List<String> _durations = [
    'Less than a week',
    '1-4 weeks',
    '1-6 months',
    'More than 6 months'
  ];

  final List<String> _opinionTypes = [
    'Diagnosis',
    'Treatment Plan',
    'Surgery Recommendation',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    final data = context.read<BookingCubit>().state.data;
    _concernController = TextEditingController(text: data['medical_concern'] as String?);
    _historyController = TextEditingController(text: data['medical_history'] as String?);
    _selectedDuration = data['duration'] as String?;
    _selectedOpinionType = data['opinion_type'] as String?;
    
    // Initial validation check (in case data was already there)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _validate();
    });
  }

  @override
  void dispose() {
    _concernController.dispose();
    _historyController.dispose();
    super.dispose();
  }

  void _validate() {
    final concern = _concernController.text.trim();
    final isValid = concern.isNotEmpty && 
                   _selectedDuration != null && 
                   _selectedOpinionType != null;
    
    context.read<BookingCubit>().updateBookingData({
      'medical_concern': concern,
      'medical_history': _historyController.text.trim(),
      'duration': _selectedDuration,
      'opinion_type': _selectedOpinionType,
      'step2_valid': isValid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Medical Information', style: AppTextStyles.header3()),
          SizedBox(height: 8.h),
          Text('Enter medical details for consultation', style: AppTextStyles.bodyRegular(color: AppColors.textSecondary)),
          SizedBox(height: 32.h),
          Text('What is the main health concern? *', style: AppTextStyles.bodyMedium()),
          SizedBox(height: 8.h),
          TextField(
            controller: _concernController,
            onChanged: (_) => _validate(),
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Briefly describe the symptoms, diagnosis, or question you have.',
              hintStyle: AppTextStyles.small(color: AppColors.textTertiary),
              border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.dorian), borderRadius: BorderRadius.circular(8.r)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.dorian), borderRadius: BorderRadius.circular(8.r)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.iris), borderRadius: BorderRadius.circular(8.r)),
            ),
          ),
          SizedBox(height: 24.h),
          Text('How long has this been an issue? *', style: AppTextStyles.small()),
          SizedBox(height: 8.h),
          _dropdown(
            'Select Duration',
            _durations,
            _selectedDuration,
            (val) {
              setState(() => _selectedDuration = val);
              _validate();
            },
          ),
          SizedBox(height: 24.h),
          Text('What do you need a second opinion on? *', style: AppTextStyles.small()),
          SizedBox(height: 8.h),
          _dropdown(
            'Select Type',
            _opinionTypes,
            _selectedOpinionType,
            (val) {
              setState(() => _selectedOpinionType = val);
              _validate();
            },
          ),
          SizedBox(height: 24.h),
          Text('Medical History (Optional)', style: AppTextStyles.small()),
          SizedBox(height: 8.h),
          TextField(
            controller: _historyController,
            onChanged: (_) => _validate(),
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Brief medical history, allergies, current medications...',
              hintStyle: AppTextStyles.small(color: AppColors.textTertiary),
              border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.dorian), borderRadius: BorderRadius.circular(8.r)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.dorian), borderRadius: BorderRadius.circular(8.r)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.iris), borderRadius: BorderRadius.circular(8.r)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdown(String hint, List<String> items, String? value, ValueChanged<String?> onChanged) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.dorian),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: AppTextStyles.bodyMedium()))).toList(),
          hint: Text(hint, style: AppTextStyles.bodyMedium(color: AppColors.textSecondary)),
          onChanged: onChanged,
          icon: Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
