import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../domain/usecases/base_usecase.dart';
import '../../../routes/app_routes.dart';
import '../../../core/utils/helpers.dart';
import '../../state/cubit/auth_cubit.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/base_entity.dart';

class AuthScreen extends StatefulWidget {
  final SignInWithEmailAndPasswordUseCase signInUseCase;
  final SignUpWithEmailAndPasswordUseCase signUpUseCase;
  final ReloadCurrentUserUseCase reloadCurrentUserUseCase;
  final SendEmailVerificationUseCase sendEmailVerificationUseCase;
  final AuthCubit authCubit;
  final int initialTabIndex;

  const AuthScreen({
    super.key,
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.reloadCurrentUserUseCase,
    required this.sendEmailVerificationUseCase,
    required this.authCubit,
    this.initialTabIndex = 0,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final AuthCubit _authCubit;

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
  bool _isGoogleSignInLoading = false;
  bool _isGoogleSignUpLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
    _authCubit = widget.authCubit;
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

  Future<void> _handleSignIn() async {
    if (!_signInFormKey.currentState!.validate()) {
      return;
    }

    await _authCubit.signIn(
      _signInEmailController.text,
      _signInPasswordController.text,
    );
  }

  Future<void> _handleSignUp() async {
    if (!_signUpFormKey.currentState!.validate()) {
      return;
    }

    await _authCubit.signUp(
      name: _signUpNameController.text,
      email: _signUpEmailController.text,
      password: _signUpPasswordController.text,
    );
  }

  Future<bool> _isProfileCompleted(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = doc.data() ?? {};
    final completed = (data['profileCompleted'] as bool?) ?? false;
    final firstName = (data['firstName'] as String?) ?? '';
    final lastName = (data['lastName'] as String?) ?? '';
    final age = (data['age'] as int?) ?? 0;
    final gender = (data['gender'] as String?) ?? '';
    if (completed) return true;
    if (firstName.isNotEmpty && lastName.isNotEmpty && age > 0 && gender.isNotEmpty) return true;
    return false;
  }

  Future<void> _navigatePostAuth(AuthUser user) async {
    final completed = await _isProfileCompleted(user.id);
    if (!mounted) return;
    if (completed) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.stepRegistration);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cloud,
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          bloc: _authCubit,
          listener: (context, state) {
            if (state is AuthError) {
              final msg = state.message;
              if (msg.toLowerCase().contains('no user found')) {
                _tabController.animateTo(1);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('No email registered. Try to sign up'),
                    backgroundColor: AppColors.error,
                  ),
                );
              } else if (msg.toLowerCase().contains('email is already in use')) {
                _tabController.animateTo(0);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Email already registered. Sign in instead'),
                    backgroundColor: AppColors.error,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            } else if (state is AuthEmailNotVerified) {
              Navigator.pushReplacementNamed(context, AppRoutes.verifyEmail);
            } else if (state is AuthAuthenticated) {
              _navigatePostAuth(state.user);
            }
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12.h, bottom: 24.h),
                child: AppAssets.logoBlueWidget(
                  width: 84.w,
                  height: 40.w,
                ),
              ),
              _buildCustomTabBar(),
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
      child: BlocBuilder<AuthCubit, AuthState>(
        bloc: _authCubit,
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Form(
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

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleSignIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.iris,
                  foregroundColor: AppColors.cloud,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                ),
                child: isLoading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.cloud,
                          ),
                        ),
                      )
                    : Text(
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
                  Navigator.pushNamed(context, AppRoutes.resetPassword);
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
              isLoading: _isGoogleSignInLoading,
              onPressed: () async {
                setState(() => _isGoogleSignInLoading = true);
                final result = await AppDependencies.googleAuthService.signInWithGoogle(forceAccountSelection: true);
                if (!context.mounted) return;
                setState(() => _isGoogleSignInLoading = false);
                if (result.canceled) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Google sign-in canceled'),backgroundColor: AppColors.error,),
                  
                  );
                } else if (result.redirectToSignUp) {
                  _tabController.animateTo(1);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('No account found. Please sign up'),backgroundColor: AppColors.error),
                  );
                } else if (result.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result.errorMessage!),
                      backgroundColor: AppColors.error,
                    ),
                  );
                } else if (result.user != null) {
                  _navigatePostAuth(result.user!);
                }
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
          );
        },
      ),
    );
  }

  Widget _buildSignUpTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: BlocBuilder<AuthCubit, AuthState>(
        bloc: _authCubit,
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Form(
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
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleSignUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.iris,
                  foregroundColor: AppColors.cloud,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                ),
                child: isLoading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.cloud,
                          ),
                        ),
                      )
                    : Text(
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
              isLoading: _isGoogleSignUpLoading,
              onPressed: () async {
                setState(() => _isGoogleSignUpLoading = true);
                final result = await AppDependencies.googleAuthService.signUpWithGoogle(forceAccountSelection: true);
                if (!context.mounted) return;
                setState(() => _isGoogleSignUpLoading = false);
                if (result.canceled) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Google sign-up canceled'),backgroundColor: AppColors.error),
                  );
                } else if (result.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result.errorMessage!),
                      backgroundColor: AppColors.error,
                    ),
                  );
                } else if (result.redirectToSignIn) {
                  _tabController.animateTo(0);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Account exists. Please sign in'),backgroundColor: AppColors.error),
                  );
                } else if (result.user != null) {
                  Navigator.pushReplacementNamed(context, AppRoutes.stepRegistration);
                }
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
          );
        },
      ),
    );
  }
}
