import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/app.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sign In Controllers
  final _signInEmailController = TextEditingController();
  final _signInPasswordController = TextEditingController();
  final _signInFormKey = GlobalKey<FormState>();

  // Sign Up Controllers
  final _signUpNameController = TextEditingController();
  final _signUpEmailController = TextEditingController();
  final _signUpPasswordController = TextEditingController();
  final _signUpConfirmPasswordController = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();

  // Password visibility
  bool _signInPasswordVisible = false;
  bool _signUpPasswordVisible = false;
  bool _signUpConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _signInEmailController.dispose();
    _signInPasswordController.dispose();
    _signUpNameController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    _signUpConfirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    if (_signInFormKey.currentState!.validate()) {
      // Navigate to home on successful sign in
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  void _handleSignUp() {
    if (_signUpFormKey.currentState!.validate()) {
      // Navigate to home on successful sign up
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cloud,
      body: SafeArea(
        child: Column(
          children: [
            // Logo at top
            Padding(
              padding: EdgeInsets.only(top: 12.h, bottom: 24.h),
              child: AppAssets.logoBlueWidget(
                width: 84.w,
                height: 40.w,
              ),
            ),
            
            // Custom Tab Bar with underline design
            _buildCustomTabBar(),
            
            // Tab View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildSignInTab(),
                  _buildSignUpTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 16.h),
      child: TabBar(
        controller: _tabController,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.iris,
            width: 3.h,
          ),
          insets: EdgeInsets.symmetric(horizontal: 0.w),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: AppColors.iris,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppTextStyles.bodyMedium(
          fontSize: 16.sp,
        ).copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: AppTextStyles.bodyMedium(
          fontSize: 16.sp,
        ),
        tabs: const [
          Tab(text: 'Sign In'),
          Tab(text: 'Sign Up'),
        ],
      ),
    );
  }

  Widget _buildSignInTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Form(
        key: _signInFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Welcome Back Header
            Text(
              'Welcome Back',
              style: AppTextStyles.header3(),
            ),
            
            SizedBox(height: 8.h),
            
            // Subtitle
            Text(
              'Let\'s get you in to Opinio',
              style: AppTextStyles.bodyMedium(
                color: AppColors.textSecondary,
              ),
            ),
            
            SizedBox(height: 40.h),
            
            // Email Field
            CustomTextField(
              controller: _signInEmailController,
              hintText: 'Email',
              prefixIcon: Padding(
                padding: REdgeInsets.all(16.0),
                child: AppAssets.personWidget(width: 20.w,height: 20.h),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            
            SizedBox(height: 16.h),
            
            // Password Field
            CustomTextField(
              controller: _signInPasswordController,
              hintText: 'Password',
              prefixIcon: Padding(
                padding: REdgeInsets.all(16),
                child: AppAssets.passwordWidget(width: 20.w,height: 20.h),
              ),
              obscureText: !_signInPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _signInPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  setState(() {
                    _signInPasswordVisible = !_signInPasswordVisible;
                  });
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            


            SizedBox(height: 32.h),

            // Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSignIn,
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
                  'Sign In',
                  style: AppTextStyles.buttonText(fontSize: 16.sp),
                ),
              ),
            ),
            
            SizedBox(height: 16.h),

            // Forgot Password

            Align(
              child: TextButton(
                onPressed: () {
                  // Handle forgot password
                },
                child: Text(
                  'Forgot Password?',
                  style: AppTextStyles.link(),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: AppColors.dorian)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'OR',
                    style: AppTextStyles.small(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: AppColors.dorian)),
              ],
            ),
            
            SizedBox(height: 24.h),
            
            // Social Buttons
            SocialButton(
              text: 'Continue with Google',
              onPressed: () {
                // Handle Google sign in
              },
            ),
            
            SizedBox(height: 12.h),
            
            SocialButton(
              text: 'Continue with Apple',
              onPressed: () {
                // Handle Apple sign in
              },
            ),
            
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Form(
        key: _signUpFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            
            // Create Account Header
            Text(
              'Create an account',
              style: AppTextStyles.header3(),
            ),
            
            SizedBox(height: 8.h),
            
            // Subtitle
            Text(
              'Let\'s get you started',
              style: AppTextStyles.bodyMedium(
                color: AppColors.textSecondary,
              ),
            ),
            
            SizedBox(height: 40.h),
            
            // Email Field
            CustomTextField(
              controller: _signUpEmailController,
              hintText: 'Email',
              prefixIcon: Padding(
                padding: REdgeInsets.all(16),
                child: AppAssets.personWidget(width: 20.w,height: 20.h),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            
            SizedBox(height: 16.h),
            
            // Password Field
            CustomTextField(
              controller: _signUpPasswordController,
              hintText: 'Password',
              prefixIcon: Padding(
                padding: REdgeInsets.all(16),
                child: AppAssets.passwordWidget(width: 20.w,height: 20.h),
              ),
              obscureText: !_signUpPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _signUpPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  setState(() {
                    _signUpPasswordVisible = !_signUpPasswordVisible;
                  });
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            
            SizedBox(height: 16.h),
            
            // Confirm Password Field
            CustomTextField(
              controller: _signUpConfirmPasswordController,
              hintText: 'Confirm Password',
              prefixIcon: Padding(
                padding: REdgeInsets.all(16),
                child: AppAssets.passwordWidget(width: 20.w,height: 20.h),
              ),
              obscureText: !_signUpConfirmPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _signUpConfirmPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  setState(() {
                    _signUpConfirmPasswordVisible = !_signUpConfirmPasswordVisible;
                  });
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _signUpPasswordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            
            SizedBox(height: 32.h),
            
            // Sign Up Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSignUp,
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
                  'Sign Up',
                  style: AppTextStyles.buttonText(fontSize: 16.sp),
                ),
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: AppColors.dorian)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'OR',
                    style: AppTextStyles.small(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: AppColors.dorian)),
              ],
            ),
            
            SizedBox(height: 24.h),
            
            // Social Buttons
            SocialButton(
              text: 'Continue with Google',
              onPressed: () {
                // Handle Google sign up
              },
            ),
            
            SizedBox(height: 12.h),
            
            SocialButton(
              text: 'Continue with Apple',
              onPressed: () {
                // Handle Apple sign up
              },
            ),
            
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
