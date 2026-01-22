import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/helpers.dart';
import '../../../domain/usecases/base_usecase.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _bottomIndex = 0;
  String? _userName;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadUser();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cloud,
      body: SafeArea(
        child:
            _bottomIndex == 0
                ? KeyedSubtree(
                  key: const ValueKey(0),
                  child: _buildHomeSection(),
                )
                : KeyedSubtree(
                  key: const ValueKey(1),
                  child: _buildMessagesSection(),
                ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: AppColors.iris,
            foregroundColor: AppColors.cloud,
            shape: const CircleBorder(),
            child: Icon(Icons.add, size: 28.w),
          ),
          SizedBox(height: 12.h),
          Text(
            'New Case',
            style: AppTextStyles.small(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  Widget _buildBottomAppBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cloud,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomAppBar(
        notchMargin: 8.w,
        color: AppColors.cloud,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _BottomNavItem(
                label: 'Home',
                selected: _bottomIndex == 0,
                icon: AppAssets.homeWidget(
                  width: 24.w,
                  height: 24.w,
                  color:
                      _bottomIndex == 0
                          ? AppColors.iris
                          : AppColors.textSecondary,
                ),
                onTap: () => setState(() => _bottomIndex = 0),
              ),
              _BottomNavItem(
                label: 'Messages',
                selected: _bottomIndex == 1,
                icon: AppAssets.messageWidget(
                  width: 24.w,
                  height: 24.w,
                  color:
                      _bottomIndex == 1
                          ? AppColors.iris
                          : AppColors.textSecondary,
                ),
                onTap: () => setState(() => _bottomIndex = 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeSection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome back,', style: AppTextStyles.small()),
                  SizedBox(height: 4.h),
                  Text(
                    _userName ?? 'User',
                    style: AppTextStyles.bodyBold(
                      color: AppColors.primary,
                      fontSize: 17.sp,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  AppAssets.notificationsWidget(width: 20.w, height: 20.h),
                  SizedBox(width: 16.w),
                  AppAssets.settingsWidget(width: 20.w, height: 20.h),
                ],
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: TabBar(
            controller: _tabController,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: AppColors.iris, width: 3.h),
              insets: EdgeInsets.zero,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.iris,
            unselectedLabelColor: AppColors.textSecondary,
            dividerColor: Colors.transparent,
            labelStyle: AppTextStyles.bodyMedium(
              fontSize: 16.sp,
            ).copyWith(fontWeight: FontWeight.w600),
            unselectedLabelStyle: AppTextStyles.bodyMedium(fontSize: 16.sp),
            tabs: const [Tab(text: 'Active'), Tab(text: 'Resolved')],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [_buildEmptyState(), _buildEmptyState()],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppAssets.calendarWidget(),
          SizedBox(height: 24.h),
          Text('No active cases', style: AppTextStyles.header3()),
          SizedBox(height: 8.h),
          Text(
            'Start your first consultation to\nconnect with specialist doctors\nfor a second opinion',
            style: AppTextStyles.bodyMedium(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
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
                'Start Your First Case',
                style: AppTextStyles.buttonText(fontSize: 16.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppAssets.messageWidget(
            width: 64.w,
            height: 64.w,
            color: AppColors.iris,
          ),
          SizedBox(height: 24.h),
          Text(
            'No messages yet',
            style: AppTextStyles.header3(),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Start a case to chat with specialists',
            style: AppTextStyles.bodyMedium(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _loadUser() async {
    final user = await AppDependencies.getCurrentUserUseCase(NoParams());
    if (!mounted) return;
    setState(() {
      _userName = user?.displayName ?? user?.email ?? 'User';
    });
  }
}

class _BottomNavItem extends StatelessWidget {
  final String label;
  final bool selected;
  final Widget icon;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.label,
    required this.selected,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(height: 6.h),
          Text(
            label,
            style: AppTextStyles.small(
              color: selected ? AppColors.iris : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
