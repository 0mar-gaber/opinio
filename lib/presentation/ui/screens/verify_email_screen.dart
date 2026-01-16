import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;

  const VerifyEmailScreen({super.key, required this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _controllers = List.generate(5, (_) => TextEditingController());
  final _focusNodes = List.generate(5, (_) => FocusNode());
  Timer? _timer;
  int _secondsRemaining = 20;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _focusNodes.first.requestFocus();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 20;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
    setState(() {});
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty) {
      _controllers[index].text = value.characters.last;
      _controllers[index].selection = TextSelection.collapsed(offset: 1);
      if (index < _focusNodes.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
    setState(() {});
  }

  String get _code => _controllers.map((c) => c.text).join();
  bool get _isComplete => _controllers.every((c) => c.text.isNotEmpty);

  void _verify() {
    if (_code.length == 5) {
      Navigator.pushNamed(context, AppRoutes.registration);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cloud,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: AppColors.dorian,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 18.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const Spacer(),
                  AppAssets.logoBlueWidget(
                    width: 84.w,
                    height: 40.w,
                  ),
                  const Spacer(),
                  SizedBox(width: 40.w),
                ],
              ),
              SizedBox(height: 60.h),
              Text(
                'Please check your email',
                style: AppTextStyles.header3(),
              ),
              SizedBox(height: 8.h),
              Text(
                'We’ve sent a code to \n${widget.email}',
                style: AppTextStyles.bodyMedium(color: AppColors.textSecondary),
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_controllers.length, (index) {
                  return SizedBox(
                    width: 56.w,
                    height: 56.w,
                    child: TextFormField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      style: AppTextStyles.header3(fontSize: 20.sp),
                      keyboardType: TextInputType.number,
                      inputFormatters:  [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (v) => _onChanged(index, v),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.cloud,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: AppColors.dorian, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: AppColors.dorian, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: AppColors.iris, width: 2),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 32.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isComplete ? _verify : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.iris,
                    foregroundColor: AppColors.cloud,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Verify',
                    style: AppTextStyles.buttonText(fontSize: 16.sp),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _startTimer,
                    child: Text(
                      'Send code again',
                      style: AppTextStyles.link(),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                    style: AppTextStyles.bodyMedium(color: AppColors.textTertiary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
