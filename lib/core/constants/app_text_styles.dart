import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._(); // Private constructor

  // Font Family
  static const String fontFamily = 'Work Sans';

  // Title/Header 1
  static TextStyle titleHeader1({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 64.sp,
      letterSpacing: -0.02, // -2%
      color: color ?? AppColors.textPrimary,
    );
  }

  // Header 2
  static TextStyle header2({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 40.sp,
      letterSpacing: -0.02, // -2%
      color: color ?? AppColors.textPrimary,
    );
  }

  // Header 3
  static TextStyle header3({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 24.sp,
      letterSpacing: -0.02, // -2%
      color: color ?? AppColors.textPrimary,
    );
  }

  // Subtitle/Body Large
  static TextStyle subtitle({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500, // Medium
      fontSize: fontSize ?? 24.sp,
      color: color ?? AppColors.textPrimary,
    );
  }

  // Body Regular
  static TextStyle bodyRegular({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal, // Regular
      fontSize: fontSize ?? 15.sp,
      height: 1.4, // 140% line height
      color: color ?? AppColors.textSecondary,
    );
  }

  // Body Medium
  static TextStyle bodyMedium({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500, // Medium
      fontSize: fontSize ?? 16.sp,
      height: 1.4, // 140% line height
      color: color ?? AppColors.textSecondary,
    );
  }

  // Body Bold
  static TextStyle bodyBold({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 15.sp,
      height: 1.4, // 140% line height
      color: color ?? AppColors.textPrimary,
    );
  }

  // Small
  static TextStyle small({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500, // Medium
      fontSize: fontSize ?? 14.sp,
      color: color ?? AppColors.textSecondary,
    );
  }

  // Pre Title
  static TextStyle preTitle({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 10.sp,
      letterSpacing: 0.03, // 3%
      color: color ?? AppColors.textPrimary,
    );
  }

  // Button Text
  static TextStyle buttonText({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 10.sp,
      letterSpacing: 0.03, // 3%
      color: color ?? AppColors.cloud,
    );
  }

  // Link
  static TextStyle link({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 16.sp,
      decoration: TextDecoration.underline,
      color: color ?? AppColors.primary,
    );
  }
}
