import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

/// App Assets - Easy access to all SVG files
/// 
/// Usage examples:
/// ```dart
/// // Simple usage
/// AppAssets.logoBlue()
/// 
/// // With size
/// AppAssets.person(width: 50, height: 50)
/// 
/// // With responsive size
/// AppAssets.password(width: 80.w, height: 80.h)
/// 
/// // With color
/// AppAssets.female(color: Colors.blue)
/// ```
class AppAssets {
  AppAssets._(); // Private constructor

  // SVG Path Constants
  static const String _svgPath = 'assets/svg';
  
  static const String logoBlue = '$_svgPath/logo-blue.svg';
  static const String logoWhite = '$_svgPath/logo-white.svg';
  static const String person = '$_svgPath/person.svg';
  static const String password = '$_svgPath/password.svg';
  static const String female = '$_svgPath/female.svg';
  static const String male = '$_svgPath/male.svg';
  static const String num2 = '$_svgPath/num-2.svg';
  static const String language = '$_svgPath/language.svg';
  static const String google = '$_svgPath/google.svg';
  static const String onboarding1 = '$_svgPath/onboarding 1.svg';
  static const String onboarding2 = '$_svgPath/onboarding 2.svg';
  static const String onboarding3 = '$_svgPath/onboarding 3.svg';

  // Helper methods for easy usage
  
  /// Logo Blue SVG
  static SvgPicture logoBlueWidget({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.asset(
      logoBlue,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null 
          ? ColorFilter.mode(color, BlendMode.srcIn) 
          : null,
    );
  }

  /// Logo White SVG
  static SvgPicture logoWhiteWidget({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.asset(
      logoWhite,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null 
          ? ColorFilter.mode(color, BlendMode.srcIn) 
          : null,
    );
  }

  /// Person SVG
  static SvgPicture personWidget({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.asset(
      person,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null 
          ? ColorFilter.mode(color, BlendMode.srcIn) 
          : null,
    );
  }

  /// Password SVG
  static SvgPicture passwordWidget({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.asset(
      password,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null 
          ? ColorFilter.mode(color, BlendMode.srcIn) 
          : null,
    );
  }

  /// Female SVG
  static SvgPicture femaleWidget({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.asset(
      female,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null 
          ? ColorFilter.mode(color, BlendMode.srcIn) 
          : null,
    );
  }

  /// Male SVG
  static SvgPicture maleWidget({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.asset(
      male,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null 
          ? ColorFilter.mode(color, BlendMode.srcIn) 
          : null,
    );
  }

  /// Number 2 SVG
  static SvgPicture num2Widget({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.asset(
      num2,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null 
          ? ColorFilter.mode(color, BlendMode.srcIn) 
          : null,
    );
  }

  /// Language SVG
  static SvgPicture languageWidget({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.asset(
      language,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null 
          ? ColorFilter.mode(color, BlendMode.srcIn) 
          : null,
    );
  }

  /// Google SVG
  static SvgPicture googleWidget({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.asset(
      google,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null 
          ? ColorFilter.mode(color, BlendMode.srcIn) 
          : null,
    );
  }

  /// Onboarding 1 SVG
  static SvgPicture onboarding1Widget({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.asset(
      onboarding1,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null 
          ? ColorFilter.mode(color, BlendMode.srcIn) 
          : null,
    );
  }

  /// Onboarding 2 SVG
  static SvgPicture onboarding2Widget({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.asset(
      onboarding2,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null 
          ? ColorFilter.mode(color, BlendMode.srcIn) 
          : null,
    );
  }

  /// Onboarding 3 SVG
  static SvgPicture onboarding3Widget({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.asset(
      onboarding3,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null 
          ? ColorFilter.mode(color, BlendMode.srcIn) 
          : null,
    );
  }

  /// Generic method to load any SVG with custom path
  static SvgPicture svgWidget(
    String path, {
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null 
          ? ColorFilter.mode(color, BlendMode.srcIn) 
          : null,
    );
  }
}
