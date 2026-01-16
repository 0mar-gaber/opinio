import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary Brand Colors
  static const Color iris = Color(0xFF4A8EED); // Primary Brand - CTAs, Focused/Active states
  
  // Secondary/Success Colors
  static const Color evergreen = Color(0xFFCDFFF3); // Secondary/success - Valid fields, Success messages
  // Note: Original hex #ED4B9E appears incorrect for green, using standard success green
  
  // Error Brand Colors
  static const Color fuschia = Color(0xFFED4B9E); // Error Brand - Links
  
  // Tertiary Brand Colors
  static const Color peach = Color(0xFFF3D9DA); // Tertiary Brand - Accenting Illustrations
  
  // Dark Colors
  static const Color onyx = Color(0xFF0E0E2C); // Dark - Overlays, Shadows, Headings
  
  // Text Colors
  static const Color slate = Color(0xFF4A4A68); // Text - Body text
  static const Color lightSlate = Color(0xFF8C8CA1); // Subtle Text - Helper text, Deemphasized text
  
  // Accent Colors
  static const Color dorian = Color(0xFFECF1F4); // Accent - Accent color, Hairlines, Subtle backgrounds
  
  // Light Colors
  static const Color cloud = Color(0xFFFAFCFE); // Light - Light mode backgrounds, Dialogs/alerts
  
  // Additional helper methods
  static const Color primary = iris;
  static const Color secondary = evergreen;
  static const Color error = fuschia;
  static const Color textPrimary = onyx;
  static const Color textSecondary = slate;
  static const Color textTertiary = lightSlate;
  static const Color background = cloud;
  static const Color surface = cloud;
}
