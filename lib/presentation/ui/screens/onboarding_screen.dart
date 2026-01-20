import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  final List<OnboardingPage> _pages = const [
    OnboardingPage(
      image: AppAssets.onboarding1,
      title: 'Share your medical case',
      description: 'Upload your reports, prescriptions, and test results.',
    ),
    OnboardingPage(
      image: AppAssets.onboarding2,
      title: 'Reviewed by verified specialists',
      description: 'Your case is reviewed by experienced doctors in their field.',
    ),
    OnboardingPage(
      image: AppAssets.onboarding3,
      title: 'Receive Expert Opinion',
      description: 'Get a second opinion to confirm, compare, or decide next steps.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging || _tabController.index != _currentIndex) {
      setState(() {
        _currentIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_tabController.index < _pages.length - 1) {
      _tabController.animateTo(_tabController.index + 1);
    } else {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('onboarding_seen', true);
    });
    Navigator.pushReplacementNamed(context, AppRoutes.welcome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cloud,
      body: SafeArea(
        child: Column(
          children: [
            // Top row with language icon and skip button
            _buildTopRow(),

            // Top Indicator with lines
            _buildTopIndicator(_currentIndex),

            // TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(), 
                children: [
                  _OnboardingPageWidget(page: _pages[0]),
                  _OnboardingPageWidget(page: _pages[1]),
                  _OnboardingPageWidget(page: _pages[2]),
                ],
              ),
            ),

            // Bottom Buttons
            _buildBottomButtons(_currentIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRow() {
    final isLastPage = _currentIndex == _pages.length - 1;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: [
          AppAssets.languageWidget(width: 16.w, height: 16.h),
          const Spacer(),
          AnimatedOpacity(
            opacity: isLastPage ? 0 : 1,
            duration: const Duration(milliseconds: 0),
            child: IgnorePointer(
              ignoring: isLastPage,
              child: TextButton(
                onPressed: _navigateToHome,
                child: Text(
                  'Skip',
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopIndicator(int currentPage) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: List.generate(
          _pages.length,
          (index) => Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: EdgeInsets.only(
                right: index < _pages.length - 1 ? 8.w : 0,
              ),
              height: 4.h,
              decoration: BoxDecoration(
                color: index <= currentPage
                    ? AppColors.iris
                    : AppColors.dorian,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons(int currentPage) {
    final bool isLastPage = currentPage == _pages.length - 1;

    return Padding(
      padding: EdgeInsets.all(24.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _nextPage,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.iris,
            foregroundColor: AppColors.cloud,
            padding: EdgeInsets.symmetric(
              horizontal: 32.w,
              vertical: 16.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            elevation: 0,
          ),
          child: Text(
            isLastPage ? 'Get Started' : 'Next',
            style: AppTextStyles.buttonText(
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage page;
  const _OnboardingPageWidget({required this.page});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              page.image,
              width: 280.w,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 40.h),
            Text(
              page.title,
              style: AppTextStyles.header3(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Text(
              page.description,
              style: AppTextStyles.bodyMedium(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });
}
