import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/gender_card.dart';

class RegistrationStepsScreen extends StatefulWidget {
  const RegistrationStepsScreen({super.key});

  @override
  State<RegistrationStepsScreen> createState() => _RegistrationStepsScreenState();
}

class _RegistrationStepsScreenState extends State<RegistrationStepsScreen> {
  final _pageController = PageController();
  int _currentStep = 0;

  final _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();

  String? _gender;

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_formKeys[_currentStep].currentState?.validate() ?? true) {
      if (_currentStep < 2) {
        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      } else {
        Navigator.pop(context);
      }
    }
  }

  void _prev() {
    if (_currentStep > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cloud,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: AppAssets.logoBlueWidget(width: 84.w, height: 40.w),
            ),
            Text('Step ${_currentStep + 1} of 3', style: AppTextStyles.small()),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: (_currentStep + 1) / 3,
                  minHeight: 6.h,
                  color: AppColors.iris,
                  backgroundColor: AppColors.dorian,
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentStep = i),
                children: [
                  _buildStep1(),
                  _buildStep2(),
                  _buildStep3(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Form(
        key: _formKeys[0],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeader(title: 'What’s your name?', subtitle: '',),
            SizedBox(height: 24.h),
            CustomTextField(
              controller: _nameController,
              hintText: 'First Name',
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              controller: _emailController,
              hintText: 'Last Name',
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 32.h),
            PrimaryButton(text: 'Next', onPressed: _next),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Form(
        key: _formKeys[1],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeader(title: 'What’s your age?', subtitle: ''),
            SizedBox(height: 24.h),
            CustomTextField(
              controller: _ageController,
              hintText: 'Age',
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                final n = int.tryParse(v);
                if (n == null || n <= 0) return 'Invalid age';
                return null;
              },
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _prev,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.iris,
                      side: BorderSide(color: AppColors.iris, width: 2),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Text('Back', style: AppTextStyles.buttonText(fontSize: 16.sp, color: AppColors.iris)),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(child: PrimaryButton(text: 'Next', onPressed: _next)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Form(
        key: _formKeys[2],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeader(title: 'Select gender', subtitle: 'Choose one'),
            SizedBox(height: 24.h),
            GenderCard(
              label: 'Male',
              icon: AppAssets.maleWidget(width: 32.w, height: 32.h),
              selected: _gender == 'male',
              onTap: () => setState(() => _gender = 'male'),
            ),
            SizedBox(height: 12.h),
            GenderCard(
              label: 'Female',
              icon: AppAssets.femaleWidget(width: 32.w, height: 32.h),
              selected: _gender == 'female',
              onTap: () => setState(() => _gender = 'female'),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _prev,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.iris,
                      side: BorderSide(color: AppColors.iris, width: 2),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Text('Back', style: AppTextStyles.buttonText(fontSize: 16.sp, color: AppColors.iris)),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: PrimaryButton(
                    text: 'Submit',
                    onPressed: _gender != null ? _next : null,
                    enabled: _gender != null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
