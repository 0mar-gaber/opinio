import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/presentation/ui/widgets/custom_text_field.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../state/cubit/booking_cubit.dart';

class SpecialtyStep extends StatefulWidget {
  const SpecialtyStep({super.key});

  @override
  State<SpecialtyStep> createState() => _SpecialtyStepState();
}

class _SpecialtyStepState extends State<SpecialtyStep> {
  // القائمة الأصلية كاملة
  final List<String> allSpecialties = const [
    "Cardiology",
    "Dermatology",
    "Endocrinology",
    "Gastroenterology",
    "Hematology",
    "Infectious Diseases",
    "Nephrology",
    "Neurology",
    "Oncology",
    "Ophthalmology",
    "Orthopedics",
    "Ear Nose and Throat",
    "Pediatrics",
    "Psychiatry",
    "Pulmonology",
    "Rheumatology",
    "Urology",
    "Obstetrics and Gynecology",
    "Family Medicine",
  ];

  // القائمة اللي هتظهر وهتتغير مع السيرش
  List<String> filteredSpecialties = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // في البداية بنعرض كل التخصصات
    filteredSpecialties = allSpecialties;
  }

  void _runFilter(String enteredKeyword) {
    List<String> results = [];
    if (enteredKeyword.isEmpty) {
      // لو السيرش فاضي رجع القائمة كاملة
      results = allSpecialties;
    } else {
      // فلترة القائمة بناءً على الحروف المكتوبة (ignore case)
      results =
          allSpecialties
              .where(
                (specialty) => specialty.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
              )
              .toList();
    }

    // تحديث الواجهة
    setState(() {
      filteredSpecialties = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Specialty',
          style: AppTextStyles.preTitle(fontSize: 18.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          'Select the medical specialty for consultation',
          style: AppTextStyles.bodyRegular(),
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          controller: searchController,
          hintText: "Search specialties...",
          prefixIcon: Icon(Icons.search, color: AppColors.lightSlate),
          // هنا بننادي على الفانكشن كل ما المستخدم يكتب حرف
          onChanged: (value) => _runFilter(value),
        ),
        Expanded(
          child:
              filteredSpecialties.isEmpty
                  ? Center(
                    child: Text(
                      "No results found",
                      style: AppTextStyles.bodyMedium(),
                    ),
                  )
                  : ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder:
                        (context, index) => SizedBox(height: 12.h),
                    itemCount: filteredSpecialties.length,
                    itemBuilder: (context, index) {
                      return _tile(
                        context, // ضفنا الـ context هنا
                        filteredSpecialties[index],
                      );
                    },
                  ),
        ),
      ],
    );
  }

  Widget _tile(BuildContext context, String title) {
    return InkWell(
      onTap: () {
        // 1. تخزين التخصص المختار في الـ Cubit (اختياري لو عندك ميثود لكده)
        // context.read<BookingCubit>().selectSpecialty(title);

        // 2. الانتقال للخطوة التالية فوراً
        context.read<BookingCubit>().nextStep();
      },
      borderRadius: BorderRadius.circular(12.r),
      // عشان الـ Ripple effect يكون مظبوط
      child: Container(
        padding: REdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.cloud,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.dorian, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.dorian.withValues(alpha: 0.3),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.iris.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: AppAssets.svgWidget(
                "assets/svg/specialty_icons/$title.svg",
                width: 32.w, // صغرت الحجم شوية عشان الـ UI يكون متناسق
                height: 32.w,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(child: Text(title, style: AppTextStyles.bodyMedium())),
            Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
