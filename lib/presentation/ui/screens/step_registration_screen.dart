import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/auth_header.dart';
import '../../../routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StepRegistrationScreen extends StatefulWidget {
  const StepRegistrationScreen({super.key});

  @override
  State<StepRegistrationScreen> createState() => _StepRegistrationScreenState();
}

class _StepRegistrationScreenState extends State<StepRegistrationScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 1;

  final _formKeys = [
    GlobalKey<FormState>(), // Step 1
    GlobalKey<FormState>(), // Step 2
    GlobalKey<FormState>(), // Step 3 (لو فيه حقول تحتاج تحقق)
  ];

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _selectedGender;
  String? _genderError;

  @override
  void dispose() {
    _pageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _next() {
    final form = _formKeys[_currentStep - 1].currentState;
    if (form != null && !form.validate()) return;

    // Step 3: تحقق من اختيار الجنس
    if (_currentStep == 3) {
      if (_selectedGender == null) {
        setState(() => _genderError = 'Please select your gender');
        return;
      } else {
        _genderError = null;
      }
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
        final ageValue = int.tryParse(_ageController.text.trim()) ?? 0;
        docRef.set({
          'uid': user.uid,
          'email': user.email ?? '',
          'displayName': user.displayName ?? '',
          'firstName': _firstNameController.text.trim(),
          'lastName': _lastNameController.text.trim(),
          'age': ageValue,
          'gender': _selectedGender,
          'profileCompleted': true,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
      Navigator.pushReplacementNamed(context, AppRoutes.home);
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cloud,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 14.h),
            AppAssets.logoBlueWidget(width: 100.w, height: 48.w),
            SizedBox(height: 24.h),
            AuthHeader(step: _currentStep, totalSteps: 3),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentStep = index + 1);
                },
                children: [
                  _buildStep1(),
                  _buildStep2(),
                  _buildStep3(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w).copyWith(bottom: 24.h),
              child: PrimaryButton(text: 'Continue', onPressed: _next),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKeys[0],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthHeader(title: 'What’s your name?'),
              SizedBox(height: 24.h),
      
              Text('First Name', style: AppTextStyles.small()),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: _firstNameController,
                hintText: 'Enter first name',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              Text('Last Name', style: AppTextStyles.small()),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: _lastNameController,
                hintText: 'Enter last name',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKeys[1],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthHeader(title: 'What’s your age?'),
              SizedBox(height: 24.h),
              Text('Age', style: AppTextStyles.small()),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: _ageController,
                hintText: 'Enter age',
                keyboardType: TextInputType.number,
                validator: (value) {
                  final age = int.tryParse(value ?? '');
                  if (age == null || age <= 0) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeader(title: 'Select you gender'),
      
            SizedBox(height: 24.h),
            Text('Select your gender', style: AppTextStyles.small()),
            SizedBox(height: 8.h),
            if (_genderError != null)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  _genderError!,
                  style: AppTextStyles.small(color: Colors.red),
                ),
              ),
            _buildGenderCard(
              icon: AppAssets.maleWidget(),
              label: 'Male',
              isSelected: _selectedGender == 'male',
              onTap: () => setState(() {
                _selectedGender = 'male';
                _genderError = null;
              }),
            ),
            SizedBox(height: 16.h),
            _buildGenderCard(
              icon: AppAssets.femaleWidget(),
              label: 'Female',
              isSelected: _selectedGender == 'female',
              onTap: () => setState(() {
                _selectedGender = 'female';
                _genderError = null;
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderCard({
    required SvgPicture icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.cloud,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(color: AppColors.dorian, blurRadius: 8.r, offset: Offset(0, 2.h)),
          ],
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.dorian,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: AppColors.dorian,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: icon,
                ),
                SizedBox(width: 12.w),
                Text(label, style: AppTextStyles.bodyMedium(color: AppColors.onyx)),
              ],
            ),
            Radio<String>(
              value: label.toLowerCase(),
              groupValue: _selectedGender,
              onChanged: (v) => setState(() {
                _selectedGender = v;
                _genderError = null;
              }),
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
